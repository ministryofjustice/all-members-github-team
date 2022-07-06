# Maintain a GitHub team consisting of all current members of our GitHub organization

Repository archived replaced by [operations-engineering script](https://github.com/ministryofjustice/operations-engineering/blob/main/.github/workflows/add-users-all-org-members-github-team.yml).

[![repo standards badge](https://img.shields.io/badge/dynamic/json?color=blue&style=for-the-badge&logo=github&label=MoJ%20Compliant&query=%24.data%5B%3F%28%40.name%20%3D%3D%20%22all-org-members-github-team%22%29%5D.status&url=https%3A%2F%2Foperations-engineering-reports.cloud-platform.service.justice.gov.uk%2Fgithub_repositories)](https://operations-engineering-reports.cloud-platform.service.justice.gov.uk/github_repositories#all-org-members-github-team "Link to report")

GitHub used to automatically provide a team consisting of all current members of the organization, but they don't anymore.

This repository maintains a [GitHub team](https://github.com/orgs/ministryofjustice/teams/all-org-members) consisting of all members of the organization, so that we can grant access to repositories where everyone should have permissions.

## How it works

This runs as a scheduled [GitHub action](https://github.com/ministryofjustice/all-org-members-github-team/blob/main/.github/workflows/add-missing-members.yml) which uses the GitHub GraphQL API to fetch a list of all organization members, and a list of all the members of the `all-org-members` team.

Any organization members who are not team members are added to the team.

The GraphQL API does not expose methods to add/remove team members, so we use the REST API for that part.

## Pre-requisites

This project requires a GitHub Personal Access Token with sufficient scopes to manage team memberships. The project assumes that this is available via the `ADMIN_GITHUB_TOKEN` environment variable.

We have an organization secret with this name, so this repository uses that token.

The organization and team name are defined as environment variables in the GitHub action.
