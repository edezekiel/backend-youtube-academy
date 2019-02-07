class Api::V1::OutlineNotesController < ApplicationController
  before_action :set_outline, only: [:create]

  def create
    @outlineNote = OutlineNote.create(
        :notebook => @notebook,
        :outline => @outline)
    if @outlineNote
      render json: { outline: @outlineNote.outline, notebook: @outlineNote.notebook }, status: :ok
    else
      render json: {errors: 'Unable to render json'},
        status: :unauthorized
    end
  end

  def set_outline
    @outline = Outline.find_by(id: params['outline'])
  end
end
