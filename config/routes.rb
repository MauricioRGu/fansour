Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  devise_scope :user do
    root to: "application#index"
  end

  #posts
  resources :posts
  
  #users
  resources :users, only: [:update]

  #customizando as rotas do devise
  devise_for :users, :skip => [:registrations], path: 'account', 
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'register'      
    }
  as :user do
    post 'account' => 'devise/registrations#create', :as => 'user_registration'
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
  get 'profiles/settings/check_profile', to: 'profiles#settings'

  #válida se o username já está sendo usado
  post 'username/:username', to: 'users#checa_username'

  #baixa as imagens de capa e avatar em show
  post 'image/:id', to: 'profiles#image_download'

  #rota de criação da assinatura
  post '/assinaturas/create', to: 'assinaturas#create' 
  post '/assinaturas/update', to: 'assinaturas#update' 
  
  resources :checagem_profiles, only: [:create]

  #centro de administração
  get 'adm/index', to: 'administration#index'
  get 'adm/checagem_profiles', to: 'administration#checagem_profiles'
  post 'adm/update_checagem_profiles', to: 'administration#update_checagem_profiles'
  
end
