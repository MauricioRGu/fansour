class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :debug_header
    before_action :checa_perfil
    #define o timezone para vizualização, de acordo com a localização do usuário 
    around_action :set_time_zone

    #after_action :update_user_online, if: :user_signed_in?

    def index 

    end

    private

    def checa_perfil
        if current_user
            #o model define se o perfil é válido ou não.
            #caso não, o usuário é forçado concluir o preenchimento dos dados faltantes
            if !current_user.valido
                flash[:notice] = "Complete o seu perfil para utilizar o sistema"
                redirect_to '/profiles/settings/profile' 
            end
        end unless action_name == 'settings' || (action_name == 'destroy' && controller_name.split('/').last == 'sessions') || controller_name == 'users'
    end

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
            cookies[:time_zone] = location.data['timezone'] if location.present? 
        end
        Time.use_zone(cookies[:time_zone]) { yield }
    end
end
