class Post < ApplicationRecord
  has_many_attached :anexos
  belongs_to :user
end
