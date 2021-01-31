class Movie < ApplicationRecord
  has_many :posts, as: :reviewable, dependent: :destroy
end
