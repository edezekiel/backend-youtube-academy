class Outline < ApplicationRecord
  belongs_to :user
  has_many :outline_notes
  has_many :notebooks, through: :outline_notes
end
