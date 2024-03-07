class User < ApplicationRecord
  #atrubuto usado para saber qual é o formulário que está sendo enviado
  attribute :kind

  #para o preenchimento dos dados pessoais
  validates :nome_completo, :cpf, :dt_nascimento, :telefone, :cep, :pais, :estado, :cidade, 
            :bairro, :endereco, :numero, presence: true, on: :update, if: -> {self.kind.in? ['personal',nil]}

  #valida a idade 
  validate :idade, on: :update
  def idade
    return unless self.dt_nascimento.present?
    now = Time.now.utc.to_date
    if now.year - self.dt_nascimento.year - ((now.month > self.dt_nascimento.month || (now.month == self.dt_nascimento.month && now.day >= self.dt_nascimento.day)) ? 0 : 1) < 18
      errors.add(:dt_nascimento, "Você precisa ter 18 anos.")
    end
  end

  #para o preenchimento dos dados do perfil
  validates :descricao, presence: true, on: :update, if: -> {self.kind.in? ['profile',nil]}

  #valor de assinatura deve ser entre 10 e 200 
  validates :valor1,  numericality: {greater_than_or_equal_to: 10, message: "O valor mínimo é R$ 10,00"}, on: :update, if: -> {self.kind.in? ['profile',nil] and self.perfil_criador}
  validates :valor1,  numericality: {less_than_or_equal_to: 200, message: "O valor máximo é R$ 200,00"}, on: :update, if: -> {self.kind.in? ['profile',nil] and self.perfil_criador}

  #descontos terão máximo permitido de 50%
  validates :desc1, numericality: {less_than_or_equal_to: 50, only_integer: true, message: "O máximo de desconto é 50%"}, on: :update, if: -> {self.kind.in? ['profile',nil]}
  validates :desc3, numericality: {less_than_or_equal_to: 50, only_integer: true, message: "O máximo de desconto é 50%"}, on: :update, if: -> {self.kind.in? ['profile',nil]}
  validates :desc6, numericality: {less_than_or_equal_to: 50, only_integer: true, message: "O máximo de desconto é 50%"}, on: :update, if: -> {self.kind.in? ['profile',nil]}

  #valida o cpf digitado
  validate :valida_cpf, on: :update
  def valida_cpf
    return unless self.cpf.present?
    if self.cpf.strip > ''
      if !CPF.valid?(self.cpf)
        errors.add(:cpf,"O CPF digitado é inválido")
      end
      if User.where(cpf: self.cpf).where.not(id: self.id).present? 
        errors.add(:cpf, "Esse CPF já está em uso em outra conta.")
      end
    end
  end

  #valida se o usuário realmente foi validado para se tornar criador
  validate :valida_criador, on: :update
  def valida_criador
    if self.perfil_criador
      checagem = self.checagem_profile.last
      if checagem.present?      
        if !checagem.analisado
          errors.add(:perfil_criador,"Seu perfil está em análise.")
          return
        end
        if !checagem.aprovado
          errors.add(:perfil_criador,"Análise de perfil negada. Envie novamente os documentos.")
          return
        end
      else
        errors.add(:perfil_criador,"Falta envio de documentos.")
      end
    end
  end

  #criação de usuário              
  validates :email, :nome_arroba, :password, presence: true, on: :create

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
         #:trackable, :timeoutable, :confirmable, :timeout_in => 4.hours

  #imagens de perfil e capa
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  has_one_attached :capa 

  #imagens de validação do perfil criador de conteudo
  has_many :checagem_profile

  #cria nome de usuario antes de criar perfil
  before_create :username
  
  #trata dados antes de salvar
  before_update :tratamento

  #relacionamentos de assinaturas
  has_many :assinaturas
  has_many :criador, through: :assinaturas 
  

  def online?
    updated_at > 2.minutes.ago
  end

  #formata os campos de valores 
  def valor1
    sprintf('%.2f',self[:valor1])
  end

  def valor3
    sprintf('%.2f',self[:valor3])
  end

  def valor6
    sprintf('%.2f',self[:valor6])
  end

  def valor1Desc
    return self.valor1.to_f * ((100 - self.desc1.to_f) / 100)
  end

  def valor3Desc
    return self.valor3.to_f * ((100 - self.desc3.to_f) / 100)
  end

  def valor6Desc
    return self.valor6.to_f * ((100 - self.desc6.to_f) / 100)
  end

  #formata data de nascimento
  #def dt_nascimento
  #  if self[:dt_nascimento].present?
  #    self[:dt_nascimento].strftime('%d/%m/%Y')      
  #  end
  #end

  #checa se o perfil está válido
  def valido    
    return self.validate
  end 

  private
  def username
    #cria nome de usuario automáticamente ao criar a conta
    nome = self.email.split('@')[0].capitalize
    nome = nome.gsub('.','')
    if User.where(nome_arroba: nome).exists?
      nome = nome + Time.now.seconds_until_end_of_day.to_s
    end
    #nome arroba é o link do perfil
    self.nome_arroba = nome
    #nome publico é o nome que os outros usuarios veem
    self.nome_publico = nome
  end

  def tratamento
    if !self.nome_publico.present?
      error.add("O nome público é requerido.")
    end

    #valor de desconto tem que ser 0 se for vazio
    if !self.desc1.present?
      self.desc1 = 0
    end

    if !self.desc3.present?
      self.desc3 = 0
    end

    if !self.desc6.present?
      self.desc6 = 0
    end

  end

  
end
