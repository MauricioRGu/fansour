class UsersController < ApplicationController
  before_action :set_user, only: %i[ update destroy ]

  def update 
    params = user_params
    if params[:valor1].present? #tratamento para dados do profile 
      #ajusta os parametros de valores
      if params[:valor1].include?(',')
        params[:valor1] = params[:valor1].gsub('.','')
        params[:valor1] = params[:valor1].gsub(',','.')
      else
        params[:valor1] += ".00"
      end

      if params[:valor3].include?(',')
        params[:valor3] = params[:valor3].gsub('.','')
        params[:valor3] = params[:valor3].gsub(',','.')
      else
        params[:valor3] += ".00"
      end
      
      if params[:valor6].include?(',')
        params[:valor6] = params[:valor6].gsub('.','')
        params[:valor6] = params[:valor6].gsub(',','.')
      else
        params[:valor6] += ".00"
      end
    end

    respond_to do |format|
      if @user.update(params)
        format.turbo_stream {flash.now[:notice] = "Dados atualizados." }
      else
        format.turbo_stream {flash.now[:notice] = "Erro na atualização, tente novamente" }
      end
    end
  end

  def checa_username
    @user = User.find_by(nome_arroba: params[:username])
    #respond_to do |format|
      if @user == current_user or !@user.present?
        render json: 'OK'
      else
        render json: 'ERRO'
      end
    #end
  end
  
  
  private 

  def set_user 
    @user = current_user
  end

  def user_params    
    params.require(:user).permit(:nome_publico,:nome_arroba,:valor1,:desc1,:valor3,:desc3,:valor6,:desc6,:descricao,:instagram,:twitter,:tiktok,:telegram,:site,
                                  :nome_completo,:email,:cpf,:dt_nascimento,:telefone,:pais,:cep,:estado,:cidade,:bairro,:endereco,:numero,:complemento)
  end
end
