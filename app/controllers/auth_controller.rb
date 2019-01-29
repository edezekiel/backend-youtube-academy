class Api::V1::AuthController < ApplicationController

  def check
    unless session.has_key?(:credentials)
      redirect to ('oauth2callback')
    end
    client_opts = JSON.parse(session[:credentials])
    auth_client = Signet::OAuth2::Client.new(client_opts)
    youtube = Google:Apis::YoutubeV3::YoutubeService.new
    channel = youtube.list_channels(part, :mine => mine, options: { authorization: auth_client })

    "<pre>#{JSON.pretty_generate(channel.to_h)}</pre>"
  end

  def login
    client_secrets = Google::APIClient::ClientSecrets.load
    auth_client = client_secrets.to_authorization
    auth_client.update!(
      :scope => 'https://www.googleapis.com/auth/youtube.force-ssl',
      :redirect_url => 'http://localhost:3000/api/v1/users/oauth2callback'
    )
    if request['code'] == nil
      auth_uri = auth_client.authorization_uri.to_s
      redirect to(auth_uri)
    else
    auth_client.code = auth_code
    auth_client.fetch_access_token!
    auth_client.client_secret = nil
    session[:credentials] = auth_client.to_json
    redirect to ('/')
  end

end
