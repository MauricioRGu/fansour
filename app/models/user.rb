class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
         #:trackable, :timeoutable, :confirmable, :timeout_in => 4.hours

  #imagens de perfil e capa
  has_one_attached :avatar
  has_one_attached :capa

  #imagens de validação do perfil criador de conteudo
  has_many_attached :validate_creator

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
