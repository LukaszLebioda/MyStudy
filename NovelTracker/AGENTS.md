# AGENTS.md — NovelTracker

## Project overview

NovelTracker is a web application for tracking novels. Users register and log
in, then create, view, edit, and delete novel entries with the following
fields: author, title, date of publishing, genre, language, summary.

## Stack

PERN: PostgreSQL (database), Express.js (API server), React (frontend UI),
Node.js (runtime).

## Infrastructure & Testing

- **Containerization**: Docker (application runs in containers)
- **CI/CD**: Jenkins (automated builds triggered by pushes to external repo)
- **Testing**: 
  - Playwright (end-to-end UI tests)
  - Postman/Newman (API tests)

## Specs

Executable Gherkin specs live in
`spec/features/<domain>/<feature-slug>.feature` (domains so far: `auth`).
A `.feature` file is frozen once gathered; only the `spec-analyst` agent, in
revise mode, may edit it afterwards.

Note: this file grows as the repository takes shape.
