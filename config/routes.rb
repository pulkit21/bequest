Rails.application.routes.draw do
  root 'home#landing'

  # get 'register',  to: "home#index"
  get '/insurance/apply',  to: "insurances#apply"
  get '/insurance/quote',  to: "insurances#apply"
  get '/insurance/payment',  to: "insurances#apply"
  get '/insurance/sign',  to: "insurances#apply"
  get '/insurance/confirm',  to: "insurances#confirm"

  get '/learn', to: 'home#learn'
  get '/blog', to: 'home#blog'
  get '/about', to: 'home#about'

  devise_for :users
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
