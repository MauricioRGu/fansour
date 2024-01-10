class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
         #:trackable, :timeoutable, :confirmable, :timeout_in => 4.hours

  #imagens de perfil e capa
  has_one_attached :avatar

  has_one_attached :capa do |cp| 

  end

  #imagens de validação do perfil criador de conteudo
  has_many_attached :validate_creator

  #cria nome de usuario antes de criar perfil
  before_create :username
  
  #valida a presença dos campos
  #validates :nome_publico, presence: true

  #trata dados antes de salvar
  before_update :tratamento
  before_validation :validates
  def validates
  end
  def tratamento
    if self.nome_publico.strip == ''
      error.add("O nome público é requerido.")
    end
  end

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

  #formata data de nascimento
  def dt_nascimento
    if self[:dt_nascimento].present?
      self[:dt_nascimento].strftime('%d/%m/%Y')      
    end
  end

  private
  def username
    #cria nome de usuario automáticamente ao criar a conta
    nome = self.email.split('@')[0].capitalize
    nome = nome.gsub('.','')
    if User.where(nome_publico: nome).exists?
      nome = nome + Time.now.seconds_until_end_of_day.to_s
    end
    #nome arroba é o link do perfil
    self.nome_arroba = nome
    #nome publico é o nome que os outros usuarios veem
    self.nome_publico = nome
  end


end
