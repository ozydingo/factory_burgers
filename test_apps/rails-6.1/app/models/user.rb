class User < ApplicationRecord
  validates :type, presence: true
  validates :login, uniqueness: true
  validates :email, uniqueness: true

  has_many :posts, foreign_key: "author_id"
  has_many :comments

  def full_name
    [firstname, lastname].select(&:present?).join(" ")
  end
end
