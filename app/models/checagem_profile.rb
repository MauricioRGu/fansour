class ChecagemProfile < ApplicationRecord
  belongs_to :user

  has_one_attached :doc_frente
  has_one_attached :doc_verso
  has_one_attached :doc_selfie

  before_create :checa_existencia

  private

  def checa_existencia 
    #não executa se o usuário já tiver uma solicitação.
    return unless !ChecagemProfile.find_by(user_id: self.user_id).present?
  end
  
end
