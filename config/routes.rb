Rails.application.routes.draw do

	get 'notifications/:id/link_through', to: 'notifications#link_through',
	as: :link_through
	get 'notifications', to: 'notifications#index'  

	root 'static_pages#welcome'
	get 'help' => 'static_pages#help'
	get 'about' => 'static_pages#about'
	get 'contact' => 'static_pages#contact'
	get 'signup' => 'users#new'
	get 'login' => 'sessions#new'
	post 'login' => 'sessions#create'
	delete 'logout' => 'sessions#destroy'
	get 'tags/:tag', to: 'posts#index', as: "tag"
	root 'posts#index'
	resources :users
	resources :tags
	resources :users do
		member do
			get :following, :followers
		end
	end
	resources :users do
		member do
			get :confirm_email
		end
	end
	resources :posts do
		member do
			get 'like'
		end
	end

	resources :posts do
		resources :comments
	end

	resources :comments do
		resources :comments
	end

	resources :posts, only: [:create, :destroy , :show , :edit ,:update, :like]
	resources :relationships, only: [:create, :destroy]
end