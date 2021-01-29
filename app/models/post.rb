class Post < ApplicationRecord
  belongs_to :user
  belongs_to :reviewable, polymorphic: true
  has_many :comments, dependent: :destroy

  validates :user, uniqueness: { scope: :reviewable, message: 'User already have a post with this movie/book ID' }
end
