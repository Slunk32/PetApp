class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.string :breed
      t.string :size
      t.string :age

      t.timestamps null: false
    end
  end
end
