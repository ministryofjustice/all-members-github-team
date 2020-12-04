class AllMembers
  class Team
    attr_reader :graphql, :login, :name

    def initialize(params)
      @login = params.fetch(:login)
      @name = params.fetch(:name)
      @graphql = params.fetch(:graphql) { GithubGraphQlClient.new(github_token: ENV.fetch("ADMIN_GITHUB_TOKEN")) }
    end

    def members
      @list ||= get_all_members
    end

    private

    def get_all_members
      members = []
      end_cursor = nil

      loop do
        data = get_members(end_cursor)
        break if data.nil?

        members += data.fetch("nodes").map { |d| d.dig("login") }
        break unless data.dig("pageInfo", "hasNextPage")

        end_cursor = data.dig("pageInfo", "endCursor")
      end

      members
    end

    def get_members(end_cursor = nil)
      json = graphql.run_query(members_query(end_cursor))
      JSON.parse(json).dig("data", "organization", "team", "members")
    end

    def members_query(end_cursor)
      after = end_cursor.nil? ? "" : %(, after: "#{end_cursor}")
      %[
          {
            organization(login: "#{login}") {
              team(slug: "#{name}") {
                id
                name
                members(first: #{PAGE_SIZE} #{after}) {
                  nodes {
                    login
                  }
                  pageInfo {
                    hasNextPage
                    endCursor
                  }
                }
              }
            }
          }
      ]
    end
  end
end
