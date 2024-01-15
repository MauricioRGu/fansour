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

  post 'username/:username', to: 'users#checa_username'

  post ':id', to: 'profiles#image_download'
end
