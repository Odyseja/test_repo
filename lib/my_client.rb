class MyClient
  require 'httparty'
  base_uri = @uri

  def initialize(params={})
    @env = params[:env].blank? ? 'prod' : params[:env]
    @base_path = base_path
    @uri = base_uri
    @key = api_key
  end

  def base_uri
    Rails.application.secrets.uri
  end

  def api_key
    Rails.application.secrets.my_token
  end

  def base_path
    @env == 'prod' ? '/api' : 'api/test'
  end

  def projects
    url = "#{base_path}/projects.json"
    sel.class.get(url)
  end

end