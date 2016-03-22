class CreatePersonalities < ActiveRecord::Migration
  def change
    create_table :personalities do |t|
      t.string :trait
      t.references :pet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
