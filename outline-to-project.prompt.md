# Outline-to-LaTeX Execution Prompt

You are an assistant operating inside this repository. Your task is to convert the high-level structure in `outline.md` into a complete LaTeX manuscript under `project/`.

## Repository Expectations
- The main entry point is `project/main.tex`, which already `\input`s section files such as `project/01_introduction/main.tex`.
- Japanese text is expected; keep existing wording style and tone, while supporting bilingual output via `language_switch.sty`.
- Ensure `language_switch.sty` is loaded from the repository root (e.g., `\input{../language_switch.sty}`) so that `\english{}` / `\japanese{}` macros can be used where parallel text is needed.
- Do not modify configuration files such as `latexmkrc`, `.devcontainer/`, or CI workflows unless explicitly requested.

## Workflow
1. Read `outline.md` to understand the target structure, required sections, and notes.
2. Review existing content in `project/` to avoid duplicating text and to reuse available commands or macros.
3. Inspect `template/` for any LaTeX class or style files and replicate the expected usage in `project/` by copying the necessary files before editing.
4. Verify that sections requiring bilingual presentation wrap phrases with `\english{...}` and `\japanese{...}` as appropriate.
5. For each item in the outline, update or create the corresponding LaTeX files under `project/`.
   - Keep the directory organisation (`project/NN_section/main.tex`).
   - Ensure `project/main.tex` includes the sections in the correct order via `\input{}` commands.
6. When adding figures, tables, or citations:
   - Prefer referencing existing assets; otherwise, leave TODO comments for missing resources.
   - Add citation keys to `project/references.bib` only if necessary.
7. At the end of the task, summarise which files were changed and note any follow-up required (e.g., external figures, unresolved references).

## Writing Guidelines
- Use standard LaTeX environments (e.g., `\section`, `\subsection`) consistent with the template.
- Keep line breaks reasonable; avoid overly long paragraphs without structure.
- Preserve existing commands/macros and respect IEEEtran conventions already in use.
- For bilingual content, place Japanese and English variants inside `\japanese{}` / `\english{}` blocks to keep texts aligned.
- Where the outline specifies bullet points or checklists, translate them into appropriate LaTeX structures (`itemize`, `enumerate`, etc.).
- Prefer Japanese text; if English terms are necessary, wrap them using `\textit{}` or quotations as appropriate.

## Validation (optional but recommended)
- After editing, run `latexmk project/main.tex` to ensure the document compiles (XeLaTeX by default).
- If issues arise, describe them in the summary instead of making ad-hoc workarounds.

Follow these steps diligently so the manuscript produced from `outline.md` aligns with the repository's layout and conventions.
