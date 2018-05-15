Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  
  root to: 'questions#index'

  concern :votable do
    member do
      post :vote_up
      post :vote_down
      delete :cancel_vote
    end
  end

  resources :questions, concerns: [:votable], shallow: true do 
    resources :comments
    resources :answers, concerns: [:votable], only: [:create, :update, :destroy] do 
      post 'best', on: :member
      resources :comments
    end
  end

  resources :attachments, only: [:destroy]

  namespace :api do 
    namespace :v1 do 
      resource :profiles do 
        get :me, on: :collection
      end
    end
  end

  

  mount ActionCable.server => '/cable'
end
