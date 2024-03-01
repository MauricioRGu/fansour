class ChecagemProfile < ApplicationRecord
  belongs_to :user

  has_one_attached :doc_frente
  has_one_attached :doc_verso
  has_one_attached :doc_selfie

  before_create :checa_existencia
  before_update :trata_resposta

  private

  def checa_existencia 
    #não executa se o usuário já tiver uma solicitação.
    return unless !ChecagemProfile.find_by(user_id: self.user_id).present?
  end
  
  def trata_resposta
    if self.analisado && self.aprovado
      self.user.update(dt_verificacao: DateTime.now)
    else
      self.user.update(dt_verificacao: nil)
    end
  end

end
