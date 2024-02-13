class ChecagemProfile < ApplicationRecord
  belongs_to :user

  has_many_attached :docs
end
