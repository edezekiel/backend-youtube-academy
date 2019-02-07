class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    users = User.all
    render json: users, status: 200
  end

  def show
    render json: @user.to_json(:include => { :notebooks => {
      :include => :outlines
      }}), status: 200
  end

  def set_user
    @user = User.find_by(googleID: params['id'])
  end
end
