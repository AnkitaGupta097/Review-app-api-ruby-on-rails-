class Book < ApplicationRecord
    has_many :posts,as: :reviewable,dependent: :destroy
    has_many :users,through: :posts
end
