#!/usr/bin/env ruby

require_relative "../lib/all_members"

pp AllMembers::Team.new(login: "ministryofjustice", name: "developers").members
