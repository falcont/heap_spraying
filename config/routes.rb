Rails.application.routes.draw do
  devise_for :users
  
  root to: 'questions#index'

  concern :votable do
    member do
      post :vote_up
      post :vote_down
    end
  end

  resources :questions, concerns: :votable do 
    resources :answers, only: [:create, :update, :destroy], shallow: true do 
      post 'best', on: :member
    end
  end

  resources :attachments, only: [:destroy]
end
