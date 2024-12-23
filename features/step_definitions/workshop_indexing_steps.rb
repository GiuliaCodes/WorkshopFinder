Given('a workshop list') do
    #workshop1 = Workshop.create!(:name=> "Workshop1", :category => "Other1", :city => "City1", :date=>"2026-01-03", :max_partecipants => 2, :organizer_id => 3 )
    #workshop2 = Workshop.create!(:name=> "Workshop2", :category => "Other2", :city => "City2", :date=>"2026-01-02", :max_partecipants => 2, :organizer_id => 3 )
    #workshop3 = Workshop.create!(:name=> "Workshop3", :category => "Other3", :city => "City3", :date=>"2026-01-01", :max_partecipants => 2, :organizer_id => 3 )

    workshop1 = Workshop.create!(:name=> "Workshop1", :category => "Other1", :city => "City1", :date=>(Date.tomorrow+3).to_s, :max_partecipants => 2, :organizer_id => 3 )
    workshop2 = Workshop.create!(:name=> "Workshop2", :category => "Other2", :city => "City2", :date=>(Date.tomorrow+2).to_s, :max_partecipants => 2, :organizer_id => 3 )
    workshop3 = Workshop.create!(:name=> "Workshop3", :category => "Other3", :city => "City3", :date=>(Date.tomorrow+1).to_s, :max_partecipants => 2, :organizer_id => 3 )

end

Then('I should see Workshops sorted in order') do
    #"Workshop3 Other3 City3 2026-01-01 organizername Show Workshop2 Other2 City2 2026-01-02 organizername Show Workshop1 Other1 City1 2026-01-03 organizername Show"
    expect(page).to have_content(/Workshop3.*Workshop2.*Workshop1/)
end
