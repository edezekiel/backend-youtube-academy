class Api::V1::OutlineNotesController < ApplicationController
  before_action :set_notebook, only: [:create]
  before_action :set_outline, only: [:create]
  before_action :set_user, only: [:create]

  def create
    if @user && @user.notebooks.include?(@notebook)
      @outlineNote = OutlineNote.create(
          :notebook => @notebook,
          :outline => @outline)
      if @outlineNote
        render json:@user.to_json(:include => [{ :notebooks => {
          :include => :outlines
          }}, :outlines ]), status: :ok
      else
        render json: {errors: 'Unable to render json'},
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

  def set_user
    @user = User.find_by(email: params['email'])
  end
end
