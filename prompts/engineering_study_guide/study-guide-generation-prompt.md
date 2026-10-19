# Populate the attached interactive study guide template

Use the attached `study-guide-skeleton.html` directly. Populate it with my subject and source material without redesigning or simplifying it.

Inputs:
- Subject: [SUBJECT]
- Audience and learning goal: [AUDIENCE AND GOAL]
- Lessons 1–20 in order: [ATTACH OR PASTE MATERIAL]
- Additional reference material: [OPTIONAL]

## Preserve the attached file exactly outside content slots

All THREE `<style>` blocks and the entire `<script>` block must remain byte for byte identical. Do not add CSS overrides or alter spacing, fonts, colors, dimensions, media queries, print rules, or progress styling. Do not substitute a previous template.

Preserve all HTML tags, attributes, classes, IDs, hierarchy, ordering, and initial accordion states. This includes the sticky toolbar, jump menu, search results, progress bar, backup/restore/reset controls, 20 lesson accordions, all 60 nested lesson parts, all 67 answer panels, eight review sections, and grouped sources.

Permitted edits only:
1. Replace text between matching `<!-- SLOT:name:START -->` and `<!-- SLOT:name:END -->` markers. Keep both markers. Insert HTML-escaped text, not new elements. Preserve the original inline emphasis and labels. Plain-text line breaks are allowed within existing code/diagram blocks.
2. Replace the text in the existing `<title>` element.
3. For each anchor immediately following `<!-- SOURCE-URL:NN -->`, replace its `href="#sources"` with the verified source URL. Preserve the comment and other attributes. Keep internal reference anchors intact.

Do not modify JavaScript identifiers, storage keys, backup formats, or filenames. The script intentionally remains the source file's exact script; its progress storage key and backup filename are still the original DDD identifiers. Guides using the same browser storage origin can therefore share progress. Changing that behavior requires a separately requested implementation change.

## Populate the existing content structure

Replace every placeholder using supplied material. Preserve the original order of 20 lessons. Match each sidebar title to its lesson title and both repeated titles inside the lesson.

Each lesson has three existing parts: original lesson content, searchable-guide material, and basic interview material. Populate all three in place, using consistent terms and complementary depth. Do not merge or delete parts. Fill the existing definitions, why/when explanations, examples, diagrams, interview questions, model answers, takeaways, quick checks, principal-level notes, and source references. Explain concepts in simple English, then use the interview answers to address decisions, trade-offs, limits, and common mistakes.

Populate all eight principal review sections, their existing cards/tables/checklists, all seven scenario questions and model answers, and the readiness rubric. Explain why and when to choose an approach and how to lead its adoption across teams. Fill all source groups and their existing reference links. Cite authoritative sources accurately; do not invent verification or claim that examples are real deployments.

Read adjacent text slots as one sentence or paragraph. Preserve meaningful fixed labels and do not repeat them in the replacement text. Keep explanations concise enough for the existing layout. Do not invent missing lesson content: use `[SOURCE MATERIAL NEEDED: specific missing information]` and report the gap if material is unavailable. If a source entry is not needed, label it `No additional reference required` and retain `href="#sources"` rather than inventing a reference.

## Verification and delivery

Compare the output to the attached skeleton. Confirm that all three style blocks, the complete script, every control, and the element structure are unchanged. Only the allowed text and source URLs may differ.

If browser access is available, check the jump menu, search and result navigation, expand/collapse controls, answer reveal, completion persistence, progress backup/restore/reset, narrow-screen layout, offline loading, and A4 print preview. Check that printing opens nested content and restores the screen state afterward. Be explicit about checks you could not perform; do not claim live browser or visual verification from a static source comparison.

Deliver one complete downloadable HTML file and a short note identifying any missing material or verification limits.
