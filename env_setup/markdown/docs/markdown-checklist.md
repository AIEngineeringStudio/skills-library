
---

# 1️⃣ Markdown Lint Checklist (What to Enforce)

Use this for **PR reviews and CI checks**.

---

## Structure
- [ ] Exactly one `# H1`
- [ ] No skipped heading levels
- [ ] Logical section order

## Formatting
- [ ] No trailing whitespace
- [ ] Blank line before/after headings
- [ ] Max 100-char lines (soft)

## Code
- [ ] Every code block has a language
- [ ] No screenshots of code
- [ ] Commands are copy-pasteable

## Lists
- [ ] Consistent bullet style
- [ ] No paragraph-sized bullets

## Links
- [ ] No raw URLs
- [ ] No broken links

## Tables
- [ ] Used only for structured data
- [ ] Proper alignment

## Readability
- [ ] No wall-of-text paragraphs
- [ ] Clear section titles
- [ ] Skimmable layout

---

# 2️⃣ Markdown Element → Best Usage Map

This tells you **when to use what**.

---

## Headings
**Use for**
- Navigation
- Structure
- TOC generation

❌ Not for styling text

---

## Bold
**Use for**
- Key rules
- Important concepts

❌ Not for entire sentences

---

## Italic
**Use for**
- Light emphasis
- Terminology introduction

---

## Inline Code
**Use for**
- Commands
- Filenames
- Config keys

```md
Set `LOG_LEVEL=INFO`
```

---

## Code Blocks
**Use for**
- Executable examples
- Config samples

❌ Not for explanations

---

## Lists
**Use for**
- Steps
- Features
- Requirements

❌ Not for prose

---

## Tables
**Use for**
- Comparisons
- Mappings
- Responsibilities

❌ Not for storytelling

---

## Blockquotes
**Use for**
- Notes
- Warnings
- Constraints

---

## Links
**Use for**
- References
- Deep dives

❌ Avoid inline URLs

---

## HTML (Escape Hatch)
**Use only when**
- Markdown cannot express layout
- Collapsible sections needed

```md
<details>
<summary>Details</summary>
Hidden info
</details>
```

