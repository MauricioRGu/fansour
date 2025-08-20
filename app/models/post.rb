class Post < ApplicationRecord
  has_many_attached :anexos
  belongs_to :user
  has_many :curtidas
end
