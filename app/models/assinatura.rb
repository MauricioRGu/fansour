class Assinatura < ApplicationRecord
  belongs_to :user
  belongs_to :criador, class_name: "User"

  before_create :tratamento

  def tratamento
    #definição de data inicial, data final e o assinante    
    self.dt_inicio = Time.current
    self.dt_fim = Time.current + self.plan.months
  end

  def identity
    return identity_encode(self.id)
  end
end
