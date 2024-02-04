class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :debug_header
    around_action :set_time_zone

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

    def set_time_zone
        #define o timezone no cookie de sessão do usuário
        if !cookies[:time_zone].present?
            ip_address = request.remote_ip
            location = Geocoder.search('168.227.84.144').first
            byebug
            cookies[:time_zone] = location.data['timezone'] if location.present? 
        end
        Time.use_zone('America/Sao_Paulo') { yield }
    end
end
