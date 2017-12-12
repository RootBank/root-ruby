require 'httparty'

class Root::Client

  def initialize(app_id, app_secret, env=:sandbox)
    @app_id = app_id
    @app_secret = app_secret
    @env = env
  end

  def get(entity, query=nil)
    response = HTTParty.get("#{api_root}/#{api_version}/#{entity}",
      query: query || {},
      basic_auth: auth)

    parse_response(response)
  end

  def post(entity, data)
    response = HTTParty.post("#{api_root}/#{api_version}/#{entity}",
      body:       data.to_json,
      basic_auth: auth,
      headers:    {'Content-Type' => 'application/json', 'Accept' => 'application/json'})

    parse_response(response)
  end

  def put(entity, data)
    response = HTTParty.put("#{api_root}/#{api_version}/#{entity}",
      body:       data.to_json,
      basic_auth: auth,
      headers:    {'Content-Type' => 'application/json', 'Accept' => 'application/json'})

    parse_response(response)
  end

  def patch(entity, data)
    response = HTTParty.patch("#{api_root}/#{api_version}/#{entity}",
      body:       data.to_json,
      basic_auth: auth,
      headers:    {'Content-Type' => 'application/json', 'Accept' => 'application/json'})

    parse_response(response)
  end

  private

  def parse_response(response)
    parsed = JSON.parse(response.body)

    case response.code
    when 200
      parsed
    when 400
      raise Root::InputError.new(parsed["message"])
    when 401, 403
      raise Root::AuthenticationError.new(parsed["message"])
    else
      raise parsed["message"]
    end
  end

  def auth
    {username: @app_id, password: @app_secret}
  end

  def api_root
    @env == :production ? "https://api.root.co.za" : "https://sandbox.root.co.za"
  end

  def api_version
    "v1"
  end

end
