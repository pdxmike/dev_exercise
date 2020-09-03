class User < ApplicationRecord
  has_secure_password

  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
end
