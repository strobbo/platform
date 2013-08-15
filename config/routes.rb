Platform::Application.routes.draw do

  resources :events


  # Homepages
	authenticated do
		root :to => 'activities#index'
	end
  root :to => redirect("/sign_in")

  resources :activities, :only => :index
  resources :events
  resources :relationships, :only => [:create, :destroy]

  resources :users do
    member do
      get :following, :followers, :show, :controller => "users/users"
    end
  end

  devise_for :users, 
		:controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :sessions => "users/sessions" }

	devise_scope :user do
		get 'sign_in', :to => 'devise/sessions#new', :as => :new_session
		get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
	end

end
