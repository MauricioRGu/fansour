class ProfilesController < ApplicationController

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
                send_data user.capa.variant( gravity: 'South-East', fill: 'grey', pointsize: point, font: '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf', draw: 'text 0,0 "FansOur.com/'+user.nome_arroba.to_s+' "').download, filename: "capa", type: user.capa.blob.content_type, disposition: 'inline'
                #send_data user.capa.download, filename: "capa", type: user.capa.blob.content_type, disposition: 'inline'
            else
                #avatar
                user = User.find_by(nome_arroba: params[:id])
                if !user.avatar.blob.metadata['width'].present?
                    user.avatar.analyze
                end
                point = user.avatar.blob.metadata['width'] * 0.028
                #send_data user.avatar.variant( gravity: 'South-East', fill: 'grey', pointsize: point, font: '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf', draw: 'text 0,0 "FansOur.com/'+user.nome_arroba.to_s+' "').download, filename: "avatar", type: user.avatar.blob.content_type, disposition: 'inline'
                send_data user.avatar.download, filename: "avatar", type: user.avatar.blob.content_type, disposition: 'inline'
            end           
            
            
        else
            redirect_to "/"
        end
    end

    def show
        @user = User.find_by(nome_arroba: params[:profile], desativado: false)
        
        #if @user.present?
        #    if @user.avatar.attached?
        #        render plain: url_for(@user.avatar)
        #    else
        #        render plain: @user.to_json
        #    end
        #else    
        #    render plain: 'Usuário não encontrado'
        #end

    end

    def explore
        if current_user 
            @users = User.where.not(id: current_user.id).where(desativado: false)
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

        render template: template
    end
end
