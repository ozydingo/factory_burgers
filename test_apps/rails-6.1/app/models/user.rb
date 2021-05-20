class User < ApplicationRecord
  validates :type, presence: true
  validates :login, uniqueness: true
  validates :email, uniqueness: true

  has_many :posts
  has_many :comments

  def full_name
    [firstname, lastname].select(&:present?).join(" ")
  end
end
