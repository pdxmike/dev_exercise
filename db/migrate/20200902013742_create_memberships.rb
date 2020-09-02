class CreateMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :memberships do |t|
      t.references :user, foreign_key: true, null: false
      t.references :organization, foreign_key: true, null: false
    end
  end
end
