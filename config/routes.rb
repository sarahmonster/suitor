Suitor::Application.routes.draw do

  devise_for :user, skip: [
    :sessions
  ], controllers: {
    confirmations: 'user/confirmations',
    invitations: 'user/invitations',
    omniauth_callbacks: 'user/omniauth_callbacks',
    registrations: 'user/registrations',
    passwords: 'user/passwords'
  }
  devise_scope :user do
    get 'use-invite' => 'user/invitations#edit', as: :invitation_accept
    get 'invite' => 'user/invitations#new', as: :new_invitation

    get 'login' => 'devise/sessions#new', as: :login
    post 'login' => 'devise/sessions#create', as: :session
    delete 'logout' => 'devise/sessions#destroy', as: :logout

    get 'sign-up' => 'user/registrations#new', as: :signup
    post 'sign-up' => 'user/registrations#create', as: :create_user_registration
  end

  resource :user, as: :profile, path: 'profile',
                  except: [:new, :show, :index, :create, :destroy]

  get 'home' => 'pages#home'
  get 'launch' => 'pages#launch'
  get 'about' => 'pages#about'
  get 'help' => 'pages#help'

  # If user is logged in, show the dashboard as root
  authenticated do
    root :to => 'dashboard#index', as: :dashboard
  end

  # If user isn't logged in, show the launch page as root
  root :to => 'pages#launch'

  # Set up job postings, and routing for nested models
  resources :postings do
    get 'archived', on: :collection
    member do
      put :archivetoggle
    end
    resources :job_applications do
      member do
        put 'followup'
      end
    end
    resources :interviews
    resources :offers
  end
end
