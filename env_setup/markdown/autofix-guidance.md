## Auto-fix guidance

---


### ✅ Usually auto-fixable (Prettier / editor)

- Trailing whitespace (MD009)
- Tabs (MD010)
- Missing newline at EOF (MD047)
- List indentation normalization (sometimes)
- Consistent spacing around lists/code blocks (MD031/MD032 often)

---

### ⚠️ Sometimes auto-fixable, sometimes not

- Heading spacing rules (MD018–MD021)
- Code fence formatting (MD046) if already fenced

---

### ❌ Not safely auto-fixable (manual)

- Duplicate headings (MD024)
- Multiple H1s (MD025)
- “Bare URL” replacements (MD034) (needs author intent)
- “Fenced code block language missing” (MD040) (needs correct language)
- “Emphasis used as heading” (MD036)

---

## Recommended Auto-fix Setup (Practical + Common)

### A) Add Prettier for formatting fixes

**Install:**
```bash
npm install -D prettier
```

**Create `.prettierrc.json`**
```json
{
  "printWidth": 100,
  "proseWrap": "always"
}
```

**Add scripts:**
```json
{
  "scripts": {
    "fmt:md": "prettier --write \"**/*.md\"",
    "lint:md": "markdownlint-cli2",
    "check:md": "npm run fmt:md && npm run lint:md"
  }
}
```

**Run:**
```bash
npm run check:md
```

---
### B) Editor workflow (fastest)

**VS Code:**

- Enable **Format on Save**
- Use Prettier as default formatter for Markdown
- Use Markdownlint extension for warnings + quick fixes


---
### C) Pre-commit (enforce before pushing)
If you use `pre-commit`, add:

```yaml
repos:
  - repo: https://github.com/pre-commit/mirrors-prettier
    rev: v4.0.0-alpha.8
    hooks:
      - id: prettier
        files: \.md$
  - repo: https://github.com/igorshubovych/markdownlint-cli2
    rev: v0.14.0
    hooks:
      - id: markdownlint-cli2
        files: \.md$
```

**Now:**
- Prettier auto-fixes formatting
- markdownlint enforces style + structure


---

## Copy-paste “Auto-fix playbook” for contributors
### Add this section to `CONTRIBUTING.md` or `README`:

```md
## Markdown formatting and linting

### Auto-fix (recommended)
```
```bash
npm run fmt:md
```

#### Lint (must pass) 
```bash
npm run lint:md
```
#### One command to format + lint
```bash
npm run check:md
```

### Common manual fixes

- Add a language to fenced code blocks (MD040).
- Ensure there is only one H1 heading (MD025).
- Replace bare URLs with [text](url) links (MD034).
---

