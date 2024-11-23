Canard::Abilities.for(:user) do
  can [:read, :create], Workshop
  can [:read], Review
  can [:create], Booking
  can [:read, :update, :destroy], User , id: user.id
end
