---
name: spec
description: Game spec workflow. "/spec setup [title]" creates a spec template in Spec/ for the developer to fill in. "/spec review [file]" has every persona in .claude/personas/ review it independently and writes Spec/review/{date}-{title}.md. "/spec refine [file]" asks the developer about unclear or redundant wording and edits from their answers.
disable-model-invocation: true
argument-hint: "setup [title] | review [file] | refine [file]"
---

# Spec

Arguments: $ARGUMENTS. The first word is the mode: `setup`, `review`, or `refine`. No mode → ask which one.

**The developer writes the spec.** Never add ideas, content, or numbers of your own to a file in `Spec/`. `setup` creates the empty template; after that, only `refine` changes it, and only from the developer's answers.

Spec file: the given file, else the only `.md` in `Spec/` (excluding `review/`), else ask which one. Dates are `YYYY-MM-DD` (today). `{title}` is the spec's file name without `.md`. If the output file already exists, append `-2`, `-3`, ... Write reports in the spec's language.

## setup [title]

1. Title defaults to `game`. Use kebab-case for the file name.
2. Copy `templates/spec.md` (next to this file) to `Spec/{title}.md`, replacing `{{title}}` with the title. Never overwrite an existing file.
3. Tell the user: the spec is theirs to write, and to run `/spec refine` and `/spec review` when ready. Nothing else.

## review [file]

1. Read the spec. If most sections still contain only their `<!-- hint -->`, stop and tell the user which sections to fill in first.
2. Launch one `persona-reviewer` agent per file in `.claude/personas/`, **in parallel, in one message**. The prompts are identical except for the persona file: the persona file path, "Mode: spec review", the spec path, the report language, and the per-reviewer section of `templates/review.md` (from `## {{Reviewer}}` to the end) as the format to return. Do not add your own opinions or hints to the prompt, and never pass one reviewer's output to another.
3. Write `Spec/review/{date}-{title}.md` from `templates/review.md`:
   - Reviewer sections go in **exactly as returned**.
   - Summary, "Raised by more than one reviewer", "Where reviewers disagree", and "Questions for the author" are built only from the reviewer sections. Add nothing of your own.
4. Do not touch the spec. In chat, show the summary table and the report path.

## refine [file]

This is about wording only. Reviewers' "Questions for the author" ask for new content, so the developer answers those by writing in the spec themselves.

1. Read the spec.
2. Find wording problems. Each one quotes the exact text:
   - **unclear**: vague words ("fun", "fast", "some", "etc."), undefined terms, a rule with no number where one is needed
   - **redundant**: the same thing said twice, or in two different ways
   - **contradiction**: two statements that cannot both be true
   - Empty sections: list them in the final message. Do not ask the user to fill them here.
3. Ask with AskUserQuestion, at most 4 questions per call, most important first. Quote the text with its section number. Options are possible readings of what the developer wrote (for redundant: keep A / keep B / merge), never new ideas. The developer can always answer in their own words.
4. Edit the spec using only the answers, keeping the developer's words and tone. Change only the quoted passages. Update "Last updated".
5. Report one line per change: `§n: "before" → "after"`. Then list empty sections, if any.
