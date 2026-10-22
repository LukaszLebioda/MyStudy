# NovelTracker

PERN-stack web application for tracking novels, built spec-driven.

## What this is

Users register and log in, then create, view, edit, and delete novel entries
with the following fields:
- Author
- Title  
- Date of publishing
- Genre
- Language
- Summary

## Technology Stack

| Component | Technology |
|---|---|
| **Database** | PostgreSQL |
| **Backend** | Express.js (Node.js) |
| **Frontend** | React |
| **Containerization** | Docker |
| **CI/CD** | Jenkins (triggered by pushes to external repo) |
| **E2E Testing** | Playwright |
| **API Testing** | Postman/Newman |

## Repository layout

| Path | Purpose |
|---|---|
| `AGENTS.md` | always-loaded baseline for AI agents (project description, stack, spec layout) |
| `README.md` | this file: human-friendly log of what we do and why |
| `spec/features/<domain>/` | frozen Gherkin specs (auth: register.feature, login-logout.feature) |
| `.kilo/agent/` | AI agent definitions (spec-analyst.md) |
| `.kilo/rules/` | always-on rules every agent session loads (core.md) |
| `.kilo/command/` | slash commands (not yet created) |
| `.kilo/kilo.json` | project permissions (allow read/edit/bash/task/skill/question/todowrite) |
| `PAM/` | reference SDD project (agents, commands, rules, skills, guide) |
| `server/` | Express.js API server (not yet created) |
| `client/` | React frontend UI (not yet created) |
| `docker/` | Docker configuration files (not yet created) |
| `jenkins/` | Jenkins pipeline configuration (not yet created) |

All Kilo config (agents, rules, commands, permissions) lives inside `.kilo/`.
Specs live in `spec/features/<domain>/` per Gherkin convention. Application
code, Docker, and Jenkins configurations not yet created.

## How we work

- PAM (`PAM/`, `COMPLETE_PAM_AGENT_GUIDE.md`) is always consulted and
  referred to, but the user decides the style: PAM-style or an alternative
  the agent suggests.
- New files are proposed first (content shown) and created only after the
  user approves.
- Known Kilo 7.8.8 bug: write-time config validator crashes ("No context
  found for instance") on Markdown config files — even the documented
  example. Harmless noise unless agents fail to register after a session
  restart.

## Current state & open decisions

**Read this first when resuming work** — kept current per `.kilo/rules/core.md`.

- **Stage**: Stack updated from MERN to PERN. Gather phase complete for auth domain. 
  Two frozen spec files exist: `spec/features/auth/register.feature` (6 registration 
  scenarios) and `spec/features/auth/login-logout.feature` (5 login/logout scenarios).
  All 11 scenarios trace to `@req:new#` tags.
- **Novel fields**: author, title, date of publishing, genre, language, summary
- **Open decisions**:
  - Email case-sensitivity (`@todo` in both spec files): is
    "Reader@Example.com" the same account as "reader@example.com"?
    Recommendation on record: yes, treat emails as case-insensitive.
  - Keep or revert the doc edits the analyst made during gather (AGENTS.md
    `## Specs` section + README progress-log entries): decision deferred.
- **Next steps** (awaiting user direction):
  1. Gather novel CRUD feature specs using spec-analyst
  2. Create implementer agent (takes frozen specs → writes tests + code for server/ 
     and client/, including PostgreSQL migrations and Playwright/Newman tests)
  3. Create Docker configuration
  4. Set up Jenkins pipeline for CI/CD
  5. Create slash command files for convenient gather/implement invocation
- **Workflow direction**: deliberately simpler than PAM's 9-agent pipeline —
  spec-analyst completed; implementer and orchestrator planned but not yet
  created; one agent/file at a time, each proposed before creation.

## Manual: how a feature becomes a spec (the gather stage)

What we did on 2026-10-12, recorded so it can be repeated for any feature:

1. The user describes the feature in plain language in the chat window —
   e.g. "Users register with email and password, log in, and log out".
2. That description is handed to the spec-analyst agent
   (`.kilo/agent/spec-analyst.md`), which may ask clarifying questions in
   plain chat before writing anything.
3. The analyst converts the description into Gherkin (Given/When/Then
   scenarios) and writes `spec/features/<domain>/<feature-slug>.feature`,
   listing every judgment call in a leading `# Analyst assumptions:`
   comment block.
4. The user reviews the file (the review gate). Once approved, the file is
   frozen: later changes go only through the analyst in revise mode.

## Progress log

- 2026-10-09 — Started the project. Analyzed PAM's spec-driven development
  (SDD) setup. Created `AGENTS.md` (minimal: project overview + MERN stack)
  and this README as the journal.
- 2026-10-09 — Every task must begin by checking whether `AGENTS.md` and
  this README need updating; recorded as an always-on rule in
  `.kilo/rules/core.md`.
- 2026-10-09 — Created first agent: `.kilo/agent/spec-analyst.md`
  (requirements → Gherkin feature files). Tried PAM-style root folders
  (agent/, rules/) bridged into `.kilo/` by symlinks; user chose
  everything-in-`.kilo/` instead — reverted, real files live in `.kilo/`
  now. Added rule: PAM is always consulted, but the user explicitly decides
  the style. Verification same day: `spec-analyst` registered and answered a
  probe correctly — agents load from `.kilo/agent/`; the write-time
  validator error is confirmed harmless noise.
- 2026-10-12 — Gathered the first feature spec:
  `spec/features/auth/register-login-logout.feature` (auth domain — user
  registration, login, logout; 11 scenarios, new-feature mode with
  `@req:new#…` tags since no domain docs exist yet). Key analyst assumptions
  awaiting critique: minimum password length 8, no auto-login after
  registering, one generic "invalid email or password" login error
  (anti-enumeration), idempotent logout. Out of scope per prompt: email
  verification, password reset, remember-me, social login, roles. One open
  `@todo`: email case-sensitivity. The `.feature` file is now frozen —
  later changes go through spec-analyst revise mode.
- 2026-10-19 — User-directed revise (spec-analyst): split the combined
  `spec/features/auth/register-login-logout.feature` into two narrower
  features — `spec/features/auth/register.feature` (6 registration
  scenarios) and `spec/features/auth/login-logout.feature` (5 login/logout
  scenarios) — and deleted the original. All scenario content, tags, and
  `@req:new#` ids are preserved byte-identical; the Background (empty user
  database) lives in both files; each file got a `# Analyst assumptions:`
  block adapted to its scope (cross-file scope-outs point at the sibling
  feature). Both files are frozen like any `.feature` file — changes go
   through spec-analyst revise mode.
- 2026-10-19 — Continuity verified: spawned a fresh general-agent subagent
  with zero conversation memory and asked it to report project status from
  files alone. It correctly identified: what the project is, current stage
  (gather phase complete, two frozen specs), open decisions (email
  case-sensitivity, doc-edit keep/revert), proposed next steps (implementer
  agent), and all working rules. Proof: everything a future agent needs
  lives in durable files (`AGENTS.md`, `.kilo/rules/core.md`, this README,
  the spec files). Created `.kilo/kilo.json` with blanket allow permissions
  (no more prompts for read/edit/bash/external-directory in this project).
- 2026-10-22 — Stack change: MERN → PERN (PostgreSQL replaces MongoDB). 
  Novel entry fields expanded: author, title, date of publishing, genre, 
  language, summary. Infrastructure requirements added: Docker for 
  containerization, Jenkins for CI/CD (triggered by pushes to external repo), 
  Playwright for E2E tests, Postman/Newman for API tests. Documentation 
  updated: `AGENTS.md` and `README.md` now reflect PERN stack and new 
  requirements. Repository layout extended with planned `docker/` and 
  `jenkins/` directories.
