- A ticket will generally be specified out by Tom at `~/vault/projects/tickets/<ticketName>.md
- Basic workflow
    1. **Always ask clarifying questions** before starting work - don't make assumptions
    2. **Write tests first** (TDD approach) - RSpec for Ruby, Jest for TypeScript
    3. **Run targeted tests** on changed files only (full suite takes ~5min)
    4. **Validate all changes** with existing test suites before considering complete
    5. **Refactor for clean code** once tests pass
    6. **Continue iterating autonomously** until acceptance criteria met

- Do not create pull requests
    - If prompted to create a PR or that a ticket is 'done':
        - Create a PR body using the pull request template in the respective repo (e.g. `.github/pull_request_template.md)
        - Save it to the bottom of the ticket file under the heading `PR body`
  - A PR body should be written in my writing style
  - A PR body should always include:
    - A reference to the ticket number (e.g. `PROJ-123`/`noticket`)
    - A brief description of the problem under a `### problem` header
    - A brief description of the solution under a `### solution` header
    - Any relevant links to documentation, resources, or discussions under a `### dev notes` header
    - A checklist of tasks for QA under a `## QA` header, including `### pre-requisites` and `### validation`
      - Assume that a software engineer will be doing the QA, and has a full local setup similar to the one on this machine (i.e. can run the app locally, has access to the database, etc.)
      - The validation section should be a numbered set of steps that a a QA enginer can run with expected outcomes
