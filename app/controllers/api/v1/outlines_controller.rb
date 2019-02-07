class Api::V1::OutlinesController < ApplicationController
  before_action :set_outline, only: [:show]
  before_action :set_user, only: [:create]

  def show
    render json: @outline.to_json(:inclue => :notebooks), status: 200
  end

  def create
    if @user
      @outline = @user.outlines.create(
          :notes => params[:notes],
          :videoId => params[:videoId],
          :videoTitle => params[:videoTitle])
      if @outline
        render json: { id: @outline.id, notes: @outline.notes, videoId: @outline.videoId, videoTitle: @outline.videoTitle, user: @outline.user }, status: :ok
      else
        render json: {errors: 'Unable to render JSON'},
          status: :unauthorized
      end
    end
  end

  def set_outline
    @outline = Outline.find_by(id: params['id'])
  end

  def set_user
    @user = User.find_by(email: params['email'])
  end
end
