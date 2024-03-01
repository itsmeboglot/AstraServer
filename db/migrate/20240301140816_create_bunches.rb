class CreateBunches < ActiveRecord::Migration[7.1]
  def change
    create_table :bunches, id: :string do |t|
      t.string :name
      t.string :description
      t.timestamps
    end

    change_column_default :bunches, :id, -> { "gen_random_uuid()" }
    change_column_null :bunches, :id, false
  end
end
