class Api::V1::LoginController < ApplicationController
  def login

    @user = User.find_or_create_by(
          :googleID => params[:googleID],
          :name => params[:name],
          :image=> params[:image])
    if @user
      render json: { name: @user.name, googleID: @user.googleID, image: @user.image }, status: :ok
    else
      render json: {errors: 'Unable to Login In'},
        status: :unauthorized
    end
  end
end
