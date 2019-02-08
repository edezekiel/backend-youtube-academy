class Api::V1::OutlineNotesController < ApplicationController
  before_action :set_notebook, only: [:create]
  before_action :set_outline, only: [:create]
  before_action :validate_id_token, only: [:create]

  def create
    if @user && @user.notebooks.include?(@notebook)
      @outlineNote = OutlineNote.create(
          :notebook => @notebook,
          :outline => @outline)
      if @outlineNote
        render json: { outlineNote: @outlineNote, outline: @outline, notebook: @notebook }, status: :ok
      else
        render json: {errors: 'Unable to add outline to notebook'},
          status: :unauthorized
      end
    end
  end

  def set_notebook
    @notebook = Notebook.find_by(id: params['notebook'])
  end

  def set_outline
    @outline = Outline.find_by(id: params['outline'])
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
  def outline_notes_params
    params.require(:id_token).permit(:email, :notebook, :outline)
  end
end
