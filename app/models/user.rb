class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         :omniauth_providers => [:twitter]

  validates :username, uniqueness: true, presence: true
  validates :username_insta, uniqueness: true
  validates :username_twitter, uniqueness: true
  validates :username_linkedin, uniqueness: true

  has_many :resources
end
