class Api::V1::NotebooksController < ApplicationController
  before_action :set_notebook, only: [:show]
  before_action :validate_id_token, only: [:create]

  # def show
    # render json: @notebook.to_json(:include => :outlines), status: 200
  # end

  def create
    if @user
      @notebook = Notebook.create(
          :title => params[:title],
          :user_id => @user.id)
      if @notebook
        render json: @notebook.to_json(:include => :outlines), status: :ok
      else
        render json: {errors: 'Unable to create notebook'},
          status: :unauthorized
      end
    end
  end

  def set_notebook
    @notebook = Notebook.find_by(id: params['notebook_id'])
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
  def notebook_params
    params.require(:id_token).permit(:email, :title, :notebook_id)
  end
end
