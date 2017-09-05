Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: "registrations", confirmations: "confirmations"  }

  root 'home#landing'

  # get 'register',  to: "home#index"
  get '/insurance/apply',  to: "insurances#apply"
  get '/insurance/quote',  to: "insurances#quote"
  get '/insurance/payment',  to: "insurances#quote"
  get '/insurance/sign',  to: "insurances#quote"
  get '/insurance/confirm',  to: "insurances#confirm"

  get '/learn', to: 'home#learn'
  get '/about', to: 'home#about'
  get '/terms', to: 'home#terms'
  get '/privacy', to: 'home#privacy'
  get '/confirm_email', to: 'home#confirm_email'
  get '/insurance/coverage', to: 'home#insurance_coverage'
  get '/user_exist', to: 'home#user_exist'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope :api, defaults: { format: :json }  do
    scope :v1 do
      resources :insurances, only: [:index, :show, :create, :update] do
        collection do
          get :chart_data
          post :stripe
          post :signature
          post :download_policy
        end
      end
    end
  end

  # get '/insure/*insure',  to: "home#index"

end
