Canard::Abilities.for(:organizer) do
  can [:read, :update, :destroy], Workshop
  
end
