#!/usr/bin/env ruby

require_relative "../lib/all_members"

ORG = "ministryofjustice"
TEAM = "all-org-members"

token = ENV.fetch("ADMIN_GITHUB_TOKEN")
graphql = GithubGraphQlClient.new(github_token: token)

org_members = AllMembers::Organization.new(
  login: ORG,
  graphql: graphql,
).members

team_members = AllMembers::Team.new(
  login: ORG,
  name: TEAM,
  graphql: graphql,
).members

team = AllMembers::RestApiTeam.new(
  organization: ORG,
  team: TEAM,
  token: token,
)

(org_members - team_members).each { |login| team.add(login) }
