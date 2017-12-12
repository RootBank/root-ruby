class Root::Insurance

  def initialize(app_id, app_secret, env=nil)
    @app_id = app_id
    @app_secret = app_secret
    @env = env || :sandbox
  end

  def generate_quote(quote_type, data={})
    post(:quotes, {type: quote_type}.merge(data))
  end

  def gadget_models
    get('gadgets/models')
  end

  private

  def post(entity, data)
    client.post("insurance/#{entity}", data)
  end

  def get(entity)
    client.get("insurance/#{entity}")
  end

  def client
    @client ||= Root::Client.new(@app_id, @app_secret, @env)
  end

end
