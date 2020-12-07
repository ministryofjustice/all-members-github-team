# Maintain a GitHub team consisting of all current members of our GitHub organisation

GitHub used to automatically provide a team consisting of all current members of the organisation, but they don't anymore.

This repository maintains an `all-org-members` GitHub team, so that we can grant access to repositories where everyone should have permissions.

## How it works

This runs as a scheduled [GitHub action](./github/workflows/add-missing-members.yml) which uses the GitHub GrphaQL API to fetch a list of all organization members, and a list of all the members of the `all-org-members` team.

Any organization memers who are not team members are added to the team.

The GrphaQL API does not expose methods to add/remove team members, so we use the REST API for that part.

## Pre-requisites

This project requires a GitHub Personal Access Token with sufficient scopes to manage team memberships. The project assumes that this is available via the `ADMIN_GITHUB_TOKEN` environment variable.

We have an organization secret with this name, so this repository uses that token.
