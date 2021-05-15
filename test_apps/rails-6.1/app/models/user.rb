class User < ApplicationRecord
  validates :type, presence: true

  has_many :posts
  has_many :comments

  def full_name
    [firstname, lastname].select(&:present?).join(" ")
  end
end
