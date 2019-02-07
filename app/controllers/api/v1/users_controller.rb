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
          :googleID => params[:googleID],
          :name => params[:name],
          :image=> params[:image])
  end
end
