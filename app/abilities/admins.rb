Canard::Abilities.for(:admin) do
  can [:read, :destroy], User
  
  can [:read, :destroy], Workshop
  
end
