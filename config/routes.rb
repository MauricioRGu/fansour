Rails.application.routes.draw do
  resources :posts
  resources :users, only: [:update]
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  devise_scope :user do
    root to: "application#index"
  end

  #visualizar perfil de usuario
  get ':profile', to: 'profiles#show'

  #procura de usuario
  get 'profiles/explorer', to: 'profiles#explore'

  #configurações de conta
  get 'profiles/settings/personal', to: 'profiles#settings'
  get 'profiles/settings/profile', to: 'profiles#settings'
  get 'profiles/settings/security', to: 'profiles#settings'
  get 'profiles/settings/assinaturas', to: 'profiles#settings'

  #válida se o username já está sendo usado
  post 'username/:username', to: 'users#checa_username'

  #baixa as imagens de capa e avatar em show
  post ':id', to: 'profiles#image_download'

  #rota de criação da assinatura
  post '/assinaturas/create', to: 'assinaturas#create' 
  post '/assinaturas/update', to: 'assinaturas#update' 
  #resources :assinaturas, only: [:create, :update]
end
