Suitor::Application.routes.draw do
  devise_for :users, skip: [:sessions], controllers: {
    confirmations: 'users/confirmations',
    invitations: 'users/invitations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  as :user do
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_session
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
    get 'sign-up' => 'users/registrations#new', as: :user_signup
    get 'use-invite' => 'users/invitations#edit', as: :invitation_accept
    get 'invite' => 'users/invitations#new', as: :new_invitation
  end

  get 'home' => 'pages#home'
  get 'launch' => 'pages#launch'
  get 'about' => 'pages#about'
  get 'help' => 'pages#help'
  get 'confirm-your-email' => 'pages#confirm_email_notice', as: :confirm_email_notice

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
  end
end
