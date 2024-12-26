Canard::Abilities.for(:organizer) do
  can [:update, :destroy], Workshop, organizer_id: user.id

  can [:read], Booking
end
