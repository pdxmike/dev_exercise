class AddUniqueIndexToMemberships < ActiveRecord::Migration[5.2]
  def change
    add_index(:memberships, [:organization_id, :user_id], unique: true)
  end
end
