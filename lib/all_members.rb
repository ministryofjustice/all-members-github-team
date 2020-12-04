require "json"
require "net/http"
require "uri"
require_relative "./github_graph_ql_client"
require_relative "./all_members/organisation"
require_relative "./all_members/team"

PAGE_SIZE = 100
