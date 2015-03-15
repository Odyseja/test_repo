require 'httparty'

class MyClient
  include HTTParty
    base_uri Rails.application.secrets.uri

  def initialize(params={})
    @env = params[:env].blank? ? 'prod' : params[:env] #prod, test
    @base_path = base_path
    @key = api_key
  end

  def headers
    {:headers => {"Authorization" => "Token token=#{api_key}"}}
  end

  def api_key
    Rails.application.secrets.my_token
  end

  def base_path
    @env == 'prod' ? '/api' : 'api/test'
  end

  def projects
    url = "#{ base_path }/projects.json"
    #url = "http://localhost:3001/projects.json"
    self.class.get(url, headers)
  end

end