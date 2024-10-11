class CreateWorkshops < ActiveRecord::Migration[6.1]
  def change
    create_table :workshops do |t|
      t.string :name
      t.string :category
      t.string :city
      t.date :date
      t.string :time
      t.string :length
      t.integer :max_partecipants
      t.string :price
      t.string :location
      t.text :description

      t.timestamps
    end
  end
end
