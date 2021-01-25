class Post < ApplicationRecord
    belongs_to :user
    belongs_to :reviewable,polymorphic: true
    has_many :comments,dependent:[:destroy]
end
