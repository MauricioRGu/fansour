class AssinaturasController < ApplicationController
  before_action :set_assinatura, only: %i[ update ]

  def create
    respond_to do |format|
      if current_user
        params = assinatura_params
        @assina = Assinatura.create(params)
          @assina.user_id = current_user.id
          if @assina.save
            format.html {redirect_to "", status: :ok, notice: "Assinatura criada com sucesso."}
          else
            format.html {redirect_to "", status: :unprocessable_entity, alert: @assina.errors.full_messages}
          end
      end
      
    end
  end

  def update
    #valida se a assinatura pertence ao usuario corrente
    if @assinatura.user.id == current_user.id
      respond_to do |format|
        if @assinatura.update(renovacao_automatica: params[:value])
          format.html {render plain: "", status: :ok}
        else
          format.html {render plain: "", status: :unprocessable_entity}
        end
      end
    end
  end
      
  private
  def set_assinatura 
    identity = params[:identity]
    id = Assinatura.identity_decode(identity,'Assinatura')
    @assinatura = Assinatura.find(id)
  end

  def assinatura_params
    params.require(:assinatura).permit(:criador_id, :valor, :plan)
  end
end
