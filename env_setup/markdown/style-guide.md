## 1️⃣ Markdown Style Guide (Enterprise-Grade)

---
### Golden Rules (Memorize These)
1. Markdown is for clarity, not decoration 
2. Structure > formatting 
3. Code must be runnable
4. Docs must survive copy-paste 
5. If it’s unclear, add a heading
#### Use this to keep consistency, readability, and diff-friendliness.

---
### ✅ Markdown Linter: `markdownlint`

#### 📁 File: [README](markdown-linter-readme.md)

#### 📁 File: `.markdownlint.json` [View Configurations](docs/.markdownlint.json)

---
### ✅ README override config: `markdownlint-cli2`

#### 📁 File: [README](markdown-linter-readme.md)

#### 📁 File: `.markdownlint-cli2.jsonc` [View Configurations](docs/.markdownlint.json)

---
### ✅ Auto-fix guidance

#### 📁 File: `autofix-guidance.md` [View](autofix-guidance.md)

---
### ✅ Markdown checklist

#### 📁 File: `markdown-checklist.md` [View](docs/markdown-checklist.md)

---
### 1.1 Headings
**Rules** 
- One # H1 per document. 
- Do not skip levels. 
- Use sentence case.

# Project Name (H1)
## Overview (H2)
### Architecture (H3)
#### Components (H4)
##### Responsibilities (H5)
###### Heading6

### 1.2 Text Formatting
**Rules** 
- Bold for **key concepts**
- Italic for *emphasis*
- ***Bold & Italic text***
- ~~Strikethrough~~
- Inline code for `exact values`, `commands`, `configs`

❌ Avoid nested styling  
❌ Avoid decorative formatting

### 1.3 Lists
**Rules** 
- Use `-` only (no `*` or `+`)
- Max 2 levels deep
- One idea per bullet
```
- Feature A
- Feature B
  - Sub-feature
```

### 1.4 Code Blocks
**Rules** 
- Always specify language
- One logical block per snippet
- No inline comments explaining obvious syntax
```bash
ls -al
```

### 1.5 Tables
**Rules** 
- Use for comparison, not prose
- Align columns
- Keep narrow

| Component | Responsibility   |
|-----------|------------------|
| API       | HTTP interface   |
| Worker    | Background jobs  |


### 1.6 Links
**Rules** 
- Descriptive text
- No raw URLs

[Icons](docs/icons.md)



### 1.7 Blockquotes
**Rules** 
- Use only for notes, warnings, or callouts

> Single line quote

> Multi-line quote  
> **Note**  
> *This runs on macOS Intel only.*

**Nested:**
> Level 1
>> Level 2
>>> Level 3

### 1.8 Whitespace
**Rules** 
- Blank line between sections
- No trailing spaces
- Max line length ~100 chars


### 1.9 Paragraphs & Line Breaks
Paragraph one.

Paragraph two.

Line break  
(using two spaces after "break")


---