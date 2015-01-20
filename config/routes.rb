Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    get '/users/sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_sessions
  end

  root to: "photos#index"

  shallow do
    resources :photos do
      resources :likes
    end
  end
end
