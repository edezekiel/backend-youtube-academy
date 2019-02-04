class User < ApplicationRecord
  has_many :outlines
  has_many :user_notebooks
  has_many :notebooks
end
