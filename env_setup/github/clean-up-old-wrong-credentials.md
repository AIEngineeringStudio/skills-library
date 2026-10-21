# Clean up old / wrong credentials (fixes repeated prompts)

---
###   🔍 Why this helps
If you previously tried password auth, your Mac may have cached bad creds.

---
### Option 1. Remove GitHub entries from Keychain (GUI)
1. Open **Keychain Access**
2. Search: gitHub.com
3. Delete entries like:
   - ``internet password`` for ``github.com`` 
   - any “git” or “GitHub” tokens that look wrong
4. Try push again (you’ll get a fresh prompt)

---
### Option 2. Clear credentials via git (repo-level)
This usually helps if helper caching is the issue:
```bash
git credential reject <<EOF
protocol=https
host=github.com
EOF

```

### Quick “which should I choose?”

- If you want **zero auth friction** and stable dev workflow: **SSH**
- If you need **corporate policy** or special routing: **HTTPS + PAT**
---


