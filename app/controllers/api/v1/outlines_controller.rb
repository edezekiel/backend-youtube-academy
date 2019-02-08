class Api::V1::OutlinesController < ApplicationController
  before_action :set_outline, only: [:show]
  before_action :validate_id_token, only: [:create]

  # def show
  #   render json: @outline.to_json(:inclue => :notebooks), status: 200
  # end

  def create
    if @user
      @outline = @user.outlines.create(
          :notes => params[:notes],
          :videoId => params[:videoId],
          :videoTitle => params[:videoTitle])
      if @outline
        render json: @outline.to_json, status: :ok
      else
        render json: {errors: 'Unable to create outline'},
          status: :unauthorized
      end
    end
  end

  def set_outline
    @outline = Outline.find_by(id: params['outline_id'])
  end

  def validate_id_token
    url = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{params["id_token"]}"
    response = RestClient.get(url)
    if JSON.parse(response.body)['email'] === params['email']
      @user = User.find_by(:email => params[:email])
    else
      render json: {errors: 'Access denied'},
        status: :unauthorized
    end
  end

  private
  def outlines_params
    params.require(:id_token).permit(:email, :notes, :videoId, :videoTitle, :outline_id)
  end
end
