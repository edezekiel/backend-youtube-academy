class Notebook < ApplicationRecord
  has_many :user_notebooks
  belongs_to :user
  has_many :outline_notes
  has_many :outlines, through: :outline_notes
end
