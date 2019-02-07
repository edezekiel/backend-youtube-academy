class Api::V1::UsersController < ApplicationController
  before_action :set_user

  def login
    if @user
      render json: @user.to_json(:include => { :notebooks => {
        :include => :outlines
        }}), status: 200
    else
      render json: {errors: 'Unable to Login In'},
        status: :unauthorized
    end
  end

  def show
    render json: @user.to_json(:include => { :notebooks => {
      :include => :outlines
      }}), status: 200
  end

  def index
    users = User.all
    render json: users
  end

  def set_user
    @user = User.find_or_create_by(
          :email => params[:email],
          :name => params[:name],
          :image=> params[:image])
  end

  private
  def user_params
    params.require(:email).permit(:name, :image, :access_token, :id_token)
  end
end
