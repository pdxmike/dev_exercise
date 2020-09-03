class Membership < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  validates :organization_id,
            uniqueness: {
              scope: :user_id,
              message: "already has a membership with this user."
            }
end
