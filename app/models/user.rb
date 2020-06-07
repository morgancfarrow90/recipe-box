class User < ActiveRecord::Base
  has_secure_password
  has_many :recipes
  has_many :genres, through: :recipes
  validates :user_email, uniqueness: true
end
