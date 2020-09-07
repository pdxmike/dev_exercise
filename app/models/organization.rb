class Organization < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true

  scope :search_by_name, -> (name) { where("lower(name) LIKE ?", "%#{name}%").order(:name) }
end
