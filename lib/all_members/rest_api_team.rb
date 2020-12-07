class AllMembers
  class RestApiTeam < Logger
    attr_reader :organization, :team, :token

    API_URL = "https://api.github.com"
    PUT = "PUT"
    DELETE = "DELETE"

    def initialize(params)
      @organization = params.fetch(:organization)
      @team = params.fetch(:team)
      @token = params.fetch(:token)
    end

    def add(login)
      log "Adding #{login} to team #{team}"
      make_http_request(PUT, login)
    end

    def remove(login)
      log "Removing #{login} from team #{team}"
      make_http_request(DELETE, login)
    end

    private

    def make_http_request(method, login)
      url = [
        API_URL,
        "orgs", organization,
        "teams", team,
        "memberships", login
      ].join("/")

      uri = URI.parse(url)

      headers = {
        "Authorization" => "token #{token}",
        "Accept" => "application/vnd.github.v3+json",
      }

      req = request(method, uri.path, headers)

      Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(req)
      end
    end

    def request(method, path, headers)
      case method
      when DELETE
        Net::HTTP::Delete.new(path, headers)
      when PUT
        Net::HTTP::Put.new(path, headers)
      else
        raise "Unhandled HTTP method #{method}"
      end
    end
  end
end
