Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: "registrations", confirmations: "confirmations"  }

  root 'home#landing'
  get 'insurance/coming_soon', to: "home#coming_soon"

  # get 'register',  to: "home#index"
  get '/insurance/product',  to: "insurances#product"
  get '/insurance/tobacco',  to: "insurances#quote"
  get '/insurance/history',  to: "insurances#quote"
  get '/insurance/blood',  to: "insurances#quote"
  get '/insurance/cholesterol',  to: "insurances#quote"
  get '/insurance/familyHistory',  to: "insurances#quote"
  get '/insurance/occupation',  to: "insurances#quote"
  get '/insurance/driving',  to: "insurances#quote"
  get '/insurance/alcohol',  to: "insurances#quote"
  get '/insurance/gender',  to: "insurances#quote"
  get '/insurance/birthday',  to: "insurances#quote"
  get '/insurance/height',  to: "insurances#quote"
  get '/insurance/weight',  to: "insurances#quote"
  get '/insurance/street',  to: "insurances#quote"
  get '/insurance/phone',  to: "insurances#quote"
  get '/insurance/license',  to: "insurances#quote"
  get '/insurance/coverage',  to: "insurances#quote"
  get '/insurance/frequency',  to: "insurances#quote"
  get '/insurance/beneficiary',  to: "insurances#quote"
  get '/insurance/payment',  to: "insurances#quote"
  get '/insurance/sign',  to: "insurances#quote"
  get '/insurance/confirm',  to: "insurances#confirm"
  get '/insurance/denied',  to: "insurances#denied"


  # get '/insurance/apply',  to: "insurances#apply"
  # get '/insurance/quote',  to: "insurances#quote"

  get '/design', to: 'home#design'
  get '/nation', to: 'home#nation'
  get '/product', to: 'home#product'
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
          put :revert_back
        end
      end
    end
  end

  # get '/insure/*insure',  to: "home#index"

end
