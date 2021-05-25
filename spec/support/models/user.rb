class User < ActiveRecord::Base
  belongs_to :group
  has_one :profile
  has_many :posts, foreign_key: "author_id"
  has_many :stars, through: :posts
end
