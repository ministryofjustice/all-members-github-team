#!/usr/bin/env ruby

require_relative "../lib/all_members"

organization = ENV.fetch("ORGANIZATION")
all_members_team = ENV.fetch("TEAM")
token = ENV.fetch("ADMIN_GITHUB_TOKEN")

graphql = GithubGraphQlClient.new(github_token: token)

org_members = AllMembers::Organization.new(
  login: organization,
  graphql: graphql,
).members

team_members = AllMembers::Team.new(
  login: organization,
  name: all_members_team,
  graphql: graphql,
).members

team = AllMembers::RestApiTeam.new(
  organization: organization,
  team: all_members_team,
  token: token,
)

(org_members - team_members).each { |login| team.add(login) }
