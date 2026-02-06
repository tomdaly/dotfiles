---
name: implement
description: Begin implementation of a ticket using the TODO list and plan in the ticket file, following TDD and committing in logical chunks
disable-model-invocation: true
argument-hint: "[ticket name, e.g. proj-1234]"
---

# 🚀 Implement the ticket

$ARGUMENTS

## context

- The ticket file with the implementation plan and todos is at `~/vault/projects/tickets/<ticketName>.md`
- Read the full ticket file first to understand the plan, acceptance criteria, and todos
- The relevant repository is in `~/dev/`

## steps

### 1. setup
- Navigate to the relevant repository
- Run `git -C <repo> checkout main && git -C <repo> pull`
  - In rails: also run `make rake` to load DB changes into local schema
- Create a new branch: `<name>/<ticket>/<short-description>`

### 2. iterate over todos
For each incomplete todo (`- [ ]`) in the ticket file:

**think first:**
- Re-read the implementation plan and any changes already made
- Identify the files that need to change
- If unsure about the approach, STOP and present questions/suggestions

**TDD cycle (red → green → refactor):**
- **red**: write a failing test first (RSpec for Ruby, Jest for TypeScript)
  - skip test for frontend UI changes unless a test file already exists
  - frontend util/lib/functionality changes should have tests
- **green**: write the minimum code to make the test pass
- **refactor**: clean up, ensure code quality

**commit:**
- Stage only the files you changed for this todo
- Commit using conventional commits (`feat:`, `fix:`, `test:`, `refactor:`)
- Single line message, no description, no attribution footer

**update ticket:**
- Mark the todo as complete: `- [x]`

### 3. validate
- Run the relevant test suite on changed files
- If tests fail, fix and amend or create a fixup commit
- Do NOT run the full test suite — echo the command for the user to run if needed

### 4. if stuck at any point
- STOP immediately
- Review the implementation plan and changes made so far
- Present the user with:
  - What you've done
  - Where you're stuck
  - Questions or alternative approaches
- Do not guess or brute-force through blockers
