Given('a workshop list') do
    workshop1 = Workshop.create!(:name=> "Workshop1", :date=>"2026-01-03", :max_partecipants => 2, :organizer_id => 3 )
    workshop2 = Workshop.create!(:name=> "Workshop2", :date=>"2026-01-02", :max_partecipants => 2, :organizer_id => 3 )
    workshop3 = Workshop.create!(:name=> "Workshop3", :date=>"2026-01-01", :max_partecipants => 2, :organizer_id => 3 )
end