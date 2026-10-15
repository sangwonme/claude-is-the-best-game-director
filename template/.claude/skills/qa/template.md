# QA: {{title}}

- Date: {{YYYY-MM-DD}}
- Build: Unity {{version}}, {{git short hash, or "not in git"}}, scene {{scene}}
- Scope: {{start}} → {{end}}
- Purpose: {{purpose}}
- Pass if: {{criterion}}
- Method: {{per step: MCP / QA driver / human play with capture}}
- Evidence: [evidence.md](./{{date}}-{{title}}/evidence.md)
- Reviewers: {{titles of the personas in .claude/personas/}}. Each evaluated the same evidence independently and did not see the others' evaluations.

## Result

**{{Pass / Pass with issues / Fail}}** against "Pass if": {{one line, citing the step that shows it}}

| Reviewer | Verdict | Top issue |
|---|---|---|
| {{persona title}} | | |

{{One row per persona.}}

## Bugs

{{Reproducible defects only. Feel and taste go in the reviewer sections.}}

| # | Severity | Step | What happened | Expected | Evidence |
|---|---|---|---|---|---|
| 1 | {{blocker / major / minor}} | {{n}} | | | {{[NN-step.png](./{{date}}-{{title}}/NN-step.png) or console line}} |

## Raised by more than one reviewer

{{One line each, naming who raised it.}}

## Where reviewers disagree

{{One line per side. The developer decides.}}

## Walkthrough

{{One block per step, in order. Every step has its screenshot.}}

### Step {{n}}: {{action}}

![{{what the screenshot shows}}](./{{date}}-{{title}}/{{NN-step}}.png)

{{One or two sentences: what the screenshot shows, what was expected, what happened. Quote relevant console lines.}}

## Not covered

{{What this run could not test (for example, feel that needs human hands) and how to test it.}}

---

{{One section per reviewer, in the order of the result table, pasted exactly as the reviewer returned it:}}

## {{Reviewer}}

**Verdict**: {{Pass / Pass with issues / Fail}}, {{one-line reason}}

**Findings**

| # | Severity | Step | Finding | Evidence | Suggestion |
|---|---|---|---|---|---|
| 1 | {{blocker / major / minor}} | {{n}} | | {{screenshot file or log line}} | |
