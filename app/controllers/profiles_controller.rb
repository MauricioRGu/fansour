class ProfilesController < ApplicationController
    before_action :valida_assinaturas, only: %i[ show ]

    def image_download
        if current_user
            p = params[:id].to_s
            if p.include?('*')
                #capa
                user = User.find_by(nome_arroba: params[:id].split("*")[0])
                if !user.capa.blob.metadata['width'].present?
                    user.capa.analyze
                end
                point = user.capa.blob.metadata['width'] * 0.028
                send_data user.capa.variant( gravity: 'South-East', fill: 'gray', pointsize: point, font: '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf', draw: 'text 0,0 "FansOur.com/'+user.nome_arroba.to_s+' "').processed.download, filename: "capa", type: user.capa.blob.content_type, disposition: 'inline'
                #send_data user.capa.download, filename: "capa", type: user.capa.blob.content_type, disposition: 'inline'
            else
                #avatar
                user = User.find_by(nome_arroba: params[:id])
                if !user.avatar.blob.metadata['width'].present?
                    user.avatar.analyze
                end
                point = user.avatar.blob.metadata['width'] * 0.028
                send_data user.avatar.variant( gravity: 'South-East', fill: 'gray', pointsize: point, font: '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf', draw: 'text 0,0 "FansOur.com/'+user.nome_arroba.to_s+' "').processed.download, filename: "avatar", type: user.avatar.blob.content_type, disposition: 'inline'
                #send_data user.avatar.download, filename: "avatar", type: user.avatar.blob.content_type, disposition: 'inline'
            end           
            
            
        else
            redirect_to "/"
        end
    end

    def show
        @user = User.find_by(nome_arroba: params[:profile], desativado: false, perfil_criador: [true,false])
        if @user.present?
            #verificar se o usuário é assinante do perfil do criador
            #@assinante = current_user.assinaturas.where(criador_id: @user.id, dt_fim: (Time.now)..)
            @assinante = current_user.assinaturas.where(criador_id: @user.id, vencida: false)
            @posts = @user.post 
        end
    end

    def explore
        #criar grupos de exploração, 
        #mostrar 30 usuários de cada 
        #top da semana 
        #
        if current_user 
            @users = User.where.not(id: current_user.id).where(desativado: false, perfil_criador: true)
        else
            @users = User.all       
        end
    end

    def settings
        @user = current_user
        url = request.url.split('/').last        
        if url == 'personal'
            template = "profiles/settings_personal"
        end
        if url == 'profile'
            template = 'profiles/settings_profile'
        end
        if url == 'security'
            template = 'profiles/security_profile'
        end
        if url == 'assinaturas'   
            @assinaturas = @user.assinaturas.where(vencida: false)         
            template = 'profiles/settings_assinaturas'
        end
        if url == 'check_profile'
            template = 'profiles/check_profile'
        end
        render template: template
    end
    
    private
    def valida_assinaturas
        current_user.assinaturas.where(vencida: false, dt_fim: ...(Time.now)).update(vencida: true)
        #Assinatura.where(dt_fim: ..(Time.now), vencida: false).update(vencida: true)
    end

end
