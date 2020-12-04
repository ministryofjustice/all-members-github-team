#!/usr/bin/env ruby

require_relative "../lib/all_members"

pp AllMembers::Organization.new(login: "ministryofjustice").members
