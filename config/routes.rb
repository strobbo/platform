Platform::Application.routes.draw do

  # Root da aplicacao
  root :to => "events#index"

  resources :events

  resources :users do
    member do
      get :following, :followers, :show, :controller => "users/users"
    end
  end

  resources :relationships, :only => [:create, :destroy]

  devise_for :users, 
		:controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :sessions => "users/sessions" }

	devise_scope :user do
		get 'sign_in', :to => 'devise/sessions#new', :as => :new_session
		get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
	end

end
