#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
# gh_transfer_repos.sh
#
# Transfer GitHub repos using the GitHub REST API via gh cli.
#
# USAGE:
#   ./gh_transfer_repos.sh \
#     --mode <MODE> \
#     --source <SOURCE> \
#     --target <TARGET> \
#     --file <REPOS_FILE>
#
# MODES:
#   personal-to-org   personal account → organization
#   org-to-personal   organization     → personal account
#   org-to-org        organization     → organization
#
# ARGUMENTS:
#   --source   GitHub username or org name (source)
#   --target   GitHub username or org name (target)
#   --file     Path to .txt file, one repo name per line
#
# EXAMPLE:
#   ./gh_transfer_repos.sh \
#     --mode personal-to-org \
#     --source mygeekboxpro \
#     --target SkillForgeLab \
#     --file repos.txt
#
# REPO FILE FORMAT (repos.txt):
#   repo-alpha
#   repo-beta
#   repo-gamma
# ─────────────────────────────────────────────────────────────

set -euo pipefail

# ── Colours ──────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Colour

# ── Defaults ─────────────────────────────────────────────────
MODE=""
SOURCE=""
TARGET=""
REPOS_FILE=""
LOG_FILE="transfer_$(date +%Y%m%d_%H%M%S).log"
SLEEP_BETWEEN=2   # seconds between API calls

# ── Usage ─────────────────────────────────────────────────────
usage() {
  grep '^#' "$0" | sed 's/^# \{0,2\}//' | head -30
  exit 1
}

# ── Parse arguments ───────────────────────────────────────────
while [[ $# -gt 0 ]]; do
  case "$1" in
    --mode)   MODE="$2";       shift 2 ;;
    --source) SOURCE="$2";     shift 2 ;;
    --target) TARGET="$2";     shift 2 ;;
    --file)   REPOS_FILE="$2"; shift 2 ;;
    --log)    LOG_FILE="$2";   shift 2 ;;
    --sleep)  SLEEP_BETWEEN="$2"; shift 2 ;;
    -h|--help) usage ;;
    *) echo "Unknown argument: $1"; usage ;;
  esac
done

# ── Validate required args ────────────────────────────────────
ERRORS=0
[[ -z "$MODE" ]]       && echo -e "${RED}ERROR:${NC} --mode is required"   && ERRORS=1
[[ -z "$SOURCE" ]]     && echo -e "${RED}ERROR:${NC} --source is required" && ERRORS=1
[[ -z "$TARGET" ]]     && echo -e "${RED}ERROR:${NC} --target is required" && ERRORS=1
[[ -z "$REPOS_FILE" ]] && echo -e "${RED}ERROR:${NC} --file is required"   && ERRORS=1

VALID_MODES=("personal-to-org" "org-to-personal" "org-to-org")
if [[ -n "$MODE" ]] && \
   [[ ! " ${VALID_MODES[*]} " =~ " ${MODE} " ]]; then
  echo -e "${RED}ERROR:${NC} --mode must be one of:"
  printf '  %s\n' "${VALID_MODES[@]}"
  ERRORS=1
fi

[[ $ERRORS -eq 1 ]] && exit 1

# ── Validate file exists ──────────────────────────────────────
if [[ ! -f "$REPOS_FILE" ]]; then
  echo -e "${RED}ERROR:${NC} File not found: $REPOS_FILE"
  exit 1
fi

# ── Validate gh auth ──────────────────────────────────────────
if ! gh auth status &>/dev/null; then
  echo -e "${RED}ERROR:${NC} Not authenticated. Run: gh auth login"
  exit 1
fi

# ── Logging helper ────────────────────────────────────────────
log() {
  local level="$1"
  local msg="$2"
  local ts
  ts=$(date '+%Y-%m-%d %H:%M:%S')
  echo "${ts} [${level}] ${msg}" >> "$LOG_FILE"
}

# ── Print summary header ──────────────────────────────────────
TOTAL=$(grep -c '[^[:space:]]' "$REPOS_FILE" || true)

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}  GitHub Repo Transfer Script${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "  Mode    : ${YELLOW}${MODE}${NC}"
echo -e "  Source  : ${YELLOW}${SOURCE}${NC}"
echo -e "  Target  : ${YELLOW}${TARGET}${NC}"
echo -e "  File    : ${REPOS_FILE} (${TOTAL} repos)"
echo -e "  Log     : ${LOG_FILE}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

log "INFO" "Transfer started | mode=$MODE source=$SOURCE target=$TARGET file=$REPOS_FILE"

# ── Counters ─────────────────────────────────────────────────
SUCCESS=0
FAILED=0
SKIPPED=0

# ── Main transfer loop ────────────────────────────────────────
while IFS= read -r repo || [[ -n "$repo" ]]; do

  # Skip blank lines and comments
  [[ -z "${repo// }" ]] && continue
  [[ "$repo" =~ ^# ]]   && continue

  repo="${repo// /}"   # trim whitespace

  echo -n "  Transferring ${CYAN}${repo}${NC} ... "

  # Build the API endpoint
  API_PATH="/repos/${SOURCE}/${repo}/transfer"

  # Call GitHub API
  HTTP_RESPONSE=$(
    gh api \
      --method POST \
      -H "Accept: application/vnd.github+json" \
      "$API_PATH" \
      -f new_owner="$TARGET" \
      --silent \
      --include \
      2>&1
  ) || true

  # Check HTTP status from response headers
  HTTP_STATUS=$(
    echo "$HTTP_RESPONSE" \
    | grep -i '^HTTP' \
    | tail -1 \
    | awk '{print $2}'
  )

  # 202 = Accepted (transfer queued async by GitHub)
  if [[ "$HTTP_STATUS" == "202" ]]; then
    echo -e "${GREEN}✓ SUCCESS${NC} (HTTP 202 Accepted)"
    log "SUCCESS" "repo=$repo source=$SOURCE target=$TARGET"
    (( SUCCESS++ ))
  else
    # Extract error message if present
    ERR_MSG=$(
      echo "$HTTP_RESPONSE" \
      | grep -o '"message":"[^"]*"' \
      | head -1 \
      | sed 's/"message":"//;s/"//'
    )
    echo -e "${RED}✗ FAILED${NC} (HTTP ${HTTP_STATUS:-unknown}) ${ERR_MSG}"
    log "FAILURE" "repo=$repo source=$SOURCE target=$TARGET http=$HTTP_STATUS err=$ERR_MSG"
    (( FAILED++ ))
  fi

  sleep "$SLEEP_BETWEEN"

done < "$REPOS_FILE"

# ── Summary ───────────────────────────────────────────────────
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "  ${GREEN}Success : ${SUCCESS}${NC}"
echo -e "  ${RED}Failed  : ${FAILED}${NC}"
echo -e "  Total   : ${TOTAL}"
echo -e "  Log     : ${LOG_FILE}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

log "INFO" "Transfer complete | success=$SUCCESS failed=$FAILED total=$TOTAL"

# Exit non-zero if any failures
[[ $FAILED -gt 0 ]] && exit 1 || exit 0