class Api::V1::NotebooksController < ApplicationController
  before_action :set_notebook, only: [:show]

  def show
    render json: @notebook(:include => :outlines), status: 200
  end

  def create
    @notebook = Notebook.create(
        :title => params[:title],
        :user_id => User.find_by(googleID: params['googleID']).id)
    if @notebook
      render json: { title: @notebook.title, user: @notebook.user }, status: :ok
    else
      render json: {errors: 'Unable to render json'},
        status: :unauthorized
    end
  end

  def set_notebook
    @notebook = Notebook.find_by(id: params['id'])
  end

end
