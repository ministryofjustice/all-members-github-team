require "json"
require "net/http"
require "uri"
require_relative "./all_members/logger"
require_relative "./github_graph_ql_client"
require_relative "./all_members/rest_api_team"
require_relative "./all_members/organization"
require_relative "./all_members/team"

PAGE_SIZE = 100
