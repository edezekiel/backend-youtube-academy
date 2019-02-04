class Api::V1::OutlinesController < ApplicationController
  before_action :set_outline, only: [:show, :update, :destroy]

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
end
