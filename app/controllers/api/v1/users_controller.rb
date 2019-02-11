class Api::V1::UsersController < ApplicationController
  before_action :validate_id_token, only: [:create, :login]

  def login
    render json: @user.to_json(:include => [{ :notebooks => {
      :include => :outlines
      }}, :outlines ]), status: 200
  end

  def show
    @user = User.find_by(:id => params["id"])
    render json: @user.to_json(:include => { :notebooks => {
      :include => :outlines
      }}), status: 200
  end

  def index
    @users = User.all
    render json: @users.to_json(:include => [{ :notebooks => {
      :include => :outlines
      }}, :outlines ]), status: 200
  end

  def validate_id_token
    url = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{params["id_token"]}"
    response = RestClient.get(url)
    if JSON.parse(response.body)['email'] === params['email']
      @user = User.find_or_create_by(
            :email => params[:email],
            :image => params[:image],
            :name => params[:name]
          )
    else
      render json: {errors: 'Unable to Login In'},
        status: :unauthorized
    end
  end

  private
  def user_params
    params.require(:id_token).permit(:email, :name, :image)
  end
end
