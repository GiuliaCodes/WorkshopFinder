Canard::Abilities.for(:partecipant) do
  can [:read, :create, :update, :destroy], Review, user_id: user.id
  can [:read, :destroy], Booking , user_id: user.id
end
