Suitor::Application.routes.draw do

  devise_for :users, skip: [:sessions], controllers: {
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  as :user do
    get 'login' => 'devise/sessions#new', :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    get 'sign-up' => 'devise/registrations#new', as: :user_signup
    # post 'signup' => 'devise/registrations#create', as: :user_signup
  end

  get 'home' => 'pages#home'
  get 'launch' => 'pages#launch'
  get 'about' => 'pages#about'
  get 'help' => 'pages#help'
  get 'dashboard' => 'dashboard#index'
  get 'confirm-your-email' => 'pages#confirm_email_notice', as: :confirm_email_notice

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
 
  # If user is logged in, show the dashboard as root
  authenticated do
    root :to => 'dashboard#index', as: :authenticated
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

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
