class ApplicationController < ActionController::Base

    #this is to redirect to user page after login, works for both local and google login 
    def after_sign_in_path_for(resource)
        # your path
        user_path(current_user.id)
    end

    

end
