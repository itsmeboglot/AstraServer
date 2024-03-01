class AddReferencesToTables < ActiveRecord::Migration[7.1]
  def change
    # Add references from Groups to Users
    add_reference :groups, :user, foreign_key: true, null: false

    # Add references from Bunches to Groups
    add_reference :bunches, :group, foreign_key: true, null: false, type: :string

    # Add references from Cards to Bunches
    add_reference :cards, :bunch, foreign_key: true, null: false, type: :string
  end

end
