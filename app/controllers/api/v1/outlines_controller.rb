class Api::V1::OutlinesController < ApplicationController
  before_action :set_outline, only: [:show]

  def show
    render json: @outline.to_json(:inclue => :notebooks), status: 200
  end

  def create
    @outline = Outline.create(
        :notes => params[:notes],
        :videoId => params[:videoId],
        :videoTitle => params[:videoTitle],
        :user_id => User.find_by(googleID: params['googleID']).id)
    if @outline
      render json: { id: @outline.id, notes: @outline.notes, videoId: @outline.videoId, videoTitle: @outline.videoTitle, user: @outline.user }, status: :ok
    else
      render json: {errors: 'Unable to Login In'},
        status: :unauthorized
    end
  end

  def set_outline
    @outline = Outline.find_by(id: params['id'])
  end

end
