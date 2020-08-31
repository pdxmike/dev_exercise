class Organization < ApplicationRecord
  validates :name, presence: true

  scope :search_by_name, -> (name) { where("lower(name) LIKE ?", "%#{name}%") }
end
