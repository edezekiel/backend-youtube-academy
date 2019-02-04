class Api::V1::OutlinesController < ApplicationController
  before_action :set_outline, only: [:show, :update, :destroy]
  before_action :set_user, only: [:useroutlines]

  def useroutlines
    outlines = @user.outlines
    render json: outlines, status: 200
  end

  def create
    @outline = Outline.create(
        :notes => params[:notes],
        :video => params[:video],
        :user_id => User.find_by(googleID: params['googleID']).id)
    if @outline
      render json: { notes: @outline.notes, video: @outline.video, user: @outline.user }, status: :ok
    else
      render json: {errors: 'Unable to Login In'},
        status: :unauthorized
    end
  end

  def set_outline
    @outline = Outline.find_by(id: params['id'])
  end

  def set_user
    @user = User.find_by(googleID: params['googleID'])
  end
end
