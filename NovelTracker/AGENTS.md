# AGENTS.md — NovelTracker

## Project overview

NovelTracker is a web application for tracking novels. Users register and log
in, then create, view, edit, and delete novel entries (title, author,
publication date, genre, personal notes).

## Stack

MERN: MongoDB (database), Express.js (API server), React (frontend UI),
Node.js (runtime).

## Specs

Executable Gherkin specs live in
`spec/features/<domain>/<feature-slug>.feature` (domains so far: `auth`).
A `.feature` file is frozen once gathered; only the `spec-analyst` agent, in
revise mode, may edit it afterwards.

Note: this file grows as the repository takes shape.
