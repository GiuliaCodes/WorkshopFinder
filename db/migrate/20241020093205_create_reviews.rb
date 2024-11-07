class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.text :description

      t.references 'user'
      t.references 'workshop'
      t.timestamps
    end
  end
end
