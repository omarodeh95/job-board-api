Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace 'api' do
    namespace 'v1' do

      resources :job_posts, only: [:index, :show] do
        resources :my_applications, only: [:new, :create, :show, :destroy]        
      end
      
      resources :my_applications, only: [:index]

      resources :my_job_posts, only: [:new, :index, :create, :show, :update, :destroy] do
        resources :applications, only: [:index, :show]
      end      
    end
  end   
end
