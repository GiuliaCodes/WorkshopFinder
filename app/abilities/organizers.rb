Canard::Abilities.for(:organizer) do
  can [:update, :destroy], Workshop, organizer_id: user.id
  #can [:read], Review

  #can [:read], User #quindi questo forse è inutile
  can [:read], Booking  ##rivedi: qui va una condizione? organizer dovrebbe poter vedere solo le booking per i suoi workshop. 
end
