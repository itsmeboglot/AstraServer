class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.references :group, null: false, foreign_key: true
      t.string :word
      t.string :definition
      t.string :example
      t.timestamps
    end
  end
end
