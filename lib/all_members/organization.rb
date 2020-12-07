class AllMembers
  class Organization < Logger
    attr_reader :graphql, :login

    def initialize(params)
      @login = params.fetch(:login)
      @graphql = params.fetch(:graphql) { GithubGraphQlClient.new(github_token: ENV.fetch("ADMIN_GITHUB_TOKEN")) }
    end

    def members
      log "Fetching all organization members"
      @list ||= get_all_members
    end

    private

    def get_all_members
      members = []
      end_cursor = nil

      loop do
        data = get_members(end_cursor)
        members += data.fetch("edges").map { |d| d.dig("node", "login") }
        break unless data.dig("pageInfo", "hasNextPage")
        end_cursor = data.dig("pageInfo", "endCursor")
      end

      members
    end

    def get_members(end_cursor = nil)
      json = graphql.run_query(members_query(end_cursor))
      JSON.parse(json).dig("data", "organization", "membersWithRole")
    end

    def members_query(end_cursor)
      after = end_cursor.nil? ? "" : %(, after: "#{end_cursor}")
      %[
          {
            organization(login: "#{login}") {
              membersWithRole(first: #{PAGE_SIZE} #{after}) {
                edges {
                  node {
                    login
                  }
                  role
                }
                pageInfo {
                  hasNextPage
                  endCursor
                }
              }
            }
          }
      ]
    end
  end
end
