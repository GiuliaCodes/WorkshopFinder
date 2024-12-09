Canard::Abilities.for(:user) do
    
  #senza if, il file sembra definire abilità per tutti gli utenti (indipendentemente dal ruolo)
  #probabilmente, non va chiamato un ruolo come il modello utente
  #una soluzione sembra essere aggiungere la condizione

  if user.is_user?            #solo per ruolo user
    can [:read, :create], Workshop
    can [:read], Review
    can [:create], Booking
  end
  
  can [:read, :update, :destroy], User , id: user.id    #a prescindere dal ruolo

end
