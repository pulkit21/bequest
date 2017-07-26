Rails.application.routes.draw do
  root 'home#landing'

  # get 'register',  to: "home#index"
  get '/insurance/apply',  to: "home#apply"
  get '/insurance/quote',  to: "home#apply"
  get '/insurance/payment',  to: "home#apply"

  get '/learn', to: 'home#learn'
  get '/blog', to: 'home#blog'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope :api, defaults: { format: :json }  do
    scope :v1 do
      resources :insurances, only: [:index, :show, :create, :update] do
        collection do
          get :chart_data
        end
      end
    end
  end

  # get '/insure/*insure',  to: "home#index"

end
