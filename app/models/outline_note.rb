class OutlineNote < ApplicationRecord
  belongs_to :notebook
  belongs_to :outline
end
