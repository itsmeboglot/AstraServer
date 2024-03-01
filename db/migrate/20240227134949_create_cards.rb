class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards, id: :string do |t|
      t.string :word
      t.string :definition
      t.string :example
      t.timestamps
    end

    change_column_default :cards, :id, -> { "gen_random_uuid()" }
    change_column_null :cards, :id, false
  end
end
