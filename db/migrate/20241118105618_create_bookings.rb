class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|

      t.references 'user'
      t.references 'workshop'

      t.timestamps
    end
  end
end
