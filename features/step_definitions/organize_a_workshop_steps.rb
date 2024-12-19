When('I select a valid date') do 
   #select_date '2026-01-01', from: 'Date'
   select_date Date.tomorrow.to_s, from: 'Date'
end

When('I select an invalid date') do 
    select_date Date.today.to_s, from: 'Date'
end
