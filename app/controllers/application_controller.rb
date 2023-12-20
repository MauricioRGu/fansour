class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :debug_header

    #after_action :update_user_online, if: :user_signed_in?

    def index 
        if !current_user
            redirect_to new_session_path(:user)
        end
    end
    private

    def update_user_online
        #atualiza o usuario a cada açao, facilita a verificação se o mesmo está online
        current_user.try :touch
    end

    def debug_header
        #tentativa de bloquear acesso de outros sites
        if !request.url.match?('localhost')
            render plain: 'Não autorizado'
        else
            
        end
    end
end
