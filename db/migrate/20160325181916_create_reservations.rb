class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.references :pet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
