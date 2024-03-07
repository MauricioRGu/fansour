class AdministrationController < ApplicationController
  before_action :checa_acesso
  before_action :set_checagem, only: :update_checagem_profiles 
  def index
  end

  def checagem_profiles
    @checagens = ChecagemProfile.where(analisado: false)
  end

  def update_checagem_profiles 
    #aprova ou recusa a solicitação de autorização de perfil criador.
    @checagem.analisado = true
    @checagem.aprovado = params[:checagem_profile][:aprovado]
    @checagem.observacao = params[:checagem_profile][:observacao].present?? params[:checagem_profile][:observacao] : nil
    respond_to do |format|
      if @checagem.save
        format.html { render plain: 'OK', status: :ok }
      else
        format.html { render plain: @checagem.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  private
  
  def checa_acesso 
    redirect_to '' unless current_user.type_user == 'admin'
  end

  def set_checagem
    @checagem = ChecagemProfile.find(params[:id])
  end
end