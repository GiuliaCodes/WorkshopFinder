class AddOrganizerIdToWorkshops < ActiveRecord::Migration[6.1]
  def change
    add_column :workshops, :organizer_id, :integer
  end
end
