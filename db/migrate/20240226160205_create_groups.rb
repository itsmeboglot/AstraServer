class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups, id: :string do |t|
      t.string :name
      t.text :description
      t.timestamps
    end

    change_column_default :groups, :id, -> { "gen_random_uuid()" }
    change_column_null :groups, :id, false
  end
end
