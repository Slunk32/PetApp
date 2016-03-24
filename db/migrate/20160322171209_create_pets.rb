class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.string :breed
      t.string :size
      t.integer :age
      t.integer :zipcode

      t.timestamps null: false
    end
  end
end
