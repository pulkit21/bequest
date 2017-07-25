Rails.application.routes.draw do
  root 'home#landing'

  # get 'register',  to: "home#index"
  get 'apply',  to: "home#apply"
  get 'quote',  to: "home#apply"

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope :api, defaults: { format: :json }  do
    scope :v1 do
      resources :insurances, only: [:index, :show, :create, :update]
    end
  end

  # get '/insure/*insure',  to: "home#index"

end
