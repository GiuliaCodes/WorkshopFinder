Given('a workshop in the past') do
    workshop = Workshop.new(:name=> "WorkshopName", :date=>"2024-01-01", :max_partecipants => 2, :organizer_id => 3 ).save(:validate => false)
end

When('I write {string}') do |string|
    fill_in 'review[description]', with: string
end
