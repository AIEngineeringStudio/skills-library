## README-only override: `markdownlint-cli2`

---
### Approach
Use **two configs**:
- .`markdownlint.json` → baseline rules for all Markdown
- `.markdownlint-cli2.jsonc` → apply an **override only to README files**

**Why:** `markdownlint-cli2` supports file-based overrides cleanly.

---
### 📦 Install markdownlint-cli2

```bash
npm install -D markdownlint-cli2
```

---
### VS Code

**Install:**
- **Markdownlint** (David Anson)

VS Code auto-detects `.markdownlint.json`.

---
### Baseline config (unchanged)

Keep your existing `.markdownlint.json` as-is (the one we created earlier).

---
### Add README override config

Create `.markdownlint-cli2.jsonc`


```json5
{
  // Use the baseline rules for everything by default
  "config": ".markdownlint.json",

  // Lint all markdown files
  "globs": [
    "**/*.md"
  ],

  // README-only overrides
  "overrides": [
    {
      // Match common README names anywhere in repo
      "files": [
        "**/README.md",
        "**/Readme.md",
        "**/readme.md"
      ],
      "config": {
        // README often starts with badges or images before the H1.
        "MD041": false,

        // README may contain duplicate headings like "Setup" in multiple sections.
        // Keep your baseline (siblings_only) if you like; otherwise relax it for README.
        // Option A: relax completely:
        // "MD024": false

        // Option B: keep it but allow common duplicates
        // (markdownlint doesn't support allowlists for MD024; it's on/off)
        "MD024": {
          "siblings_only": true
        },

        // READMEs often include bare URLs for quick copy/paste.
        // If you want to allow them ONLY in README, disable MD034 here.
        // If you prefer strict everywhere, keep MD034 true and do not disable this.
        "MD034": false,

        // README sometimes intentionally uses multiple consecutive blank lines
        // around big sections; keep strict in other docs.
        "MD012": {
          "maximum": 2
        }
      }
    }
  ]
}

```

---
### Run it

Add a script in `package.json`:
```json
{
  "scripts": {
    "lint:md": "markdownlint-cli2"
  }
}
```

Run:
```bash
npm run lint:md
```

---
### 🚨 What This Will Catch Immediately

- Missing code block languages ❌
- Multiple H1s ❌
- Messy lists ❌
- Bare URLs ❌
- Inconsistent spacing ❌
- Sloppy headings ❌

---