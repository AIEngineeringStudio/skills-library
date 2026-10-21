## Markdown Linter: `markdownlint`

---
### This is the most widely supported Markdown linter.  
- Strict but practical
- Optimized for `READMEs`, `architecture docs`, and `technical documentation`.

#### Supports:
- CLI 
- VS Code extension
- CI 
- Pre-commit hooks

---
### 📌 What This Config Enforces (Mapped to Our Rules)
| Rule                        | Enforced |
|-----------------------------|----------|
| One H1                      |    ✅    |
| No skipped headings         |    ✅    |
| `-` bullets only            |    ✅    |
| Language-tagged code blocks |    ✅    |
| No bare URLs                |    ✅    |
| Readable spacing            |    ✅    |
| Enterprise-safe HTML        |    ✅    |
| Diff-friendly formatting    |    ✅    |


---
### 📦 Installation

**CLI**
```bash
npm install -g markdownlint-cli
```
**Run:**
```bash
markdownlint "**/*.md"
```
---

### VS Code

**Install:**
- **Markdownlint** (David Anson)

VS Code auto-detects `.markdownlint.json`.

---
### Pre-commit Hook (Recommended)

```yaml
repos:
  - repo: https://github.com/igorshubovych/markdownlint-cli
    rev: v0.39.0
    hooks:
      - id: markdownlint
```

---
### CI Example (GitHub Actions)

```yaml
- name: Lint Markdown
  run: markdownlint "**/*.md"
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