class ProfilesController < ApplicationController

    def image_download
        if current_user
            file = ActiveStorage::Attachment.find(params[:id])
            send_data file.download, filename: "file.blob.filename", type: file.blob.content_type, disposition: 'inline'
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
