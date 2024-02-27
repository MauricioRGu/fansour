class ChecagemProfilesController < ApplicationController
  before_action :autoriza, only: %i[ edit update ]
  before_action :set_checagem, only: %i[ edit update ]  

  def create
    if !current_user.checagem_profile.present?
      @checagem = ChecagemProfile.new(checagem_params)
      @checagem.user_id = current_user.id
      respond_to do |format|
        if @checagem.save
          format.html {render partial: "checagem_profiles/view", location: @checagem, status: :created }
          #format.html { redirect_to checagem_url(@checagem), notice: "checagem was successfully created." }
          format.json { render :show, status: :created, location: @checagem }
        else
          format.html { render partial: 'profiles/forms/docs_autorizacao', status: :unprocessable_entity }
          format.json { render json: @checagem.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  
  private
    def autoriza
      #criar autorizacao na atualização ou deleção
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_checagem
      @checagem = ChecagemProfiles.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def checagem_params
      params.require(:checagem_profile).permit(:observacao, :aprovado, :doc_frente, :doc_verso, :doc_selfie)
    end
end
