Rails.application.routes.draw do
  devise_for :users
  
  root to: 'questions#index'

  concern :votable do
    member do
      post :vote_up
      post :vote_down
      delete :cancel_vote
    end
  end

  concern :commentable do 
    post :comment, on: :member
  end

  resources :questions, concerns: [:votable, :commentable], shallow: true do 
    resources :answers, concerns: [:votable, :commentable], only: [:create, :update, :destroy] do 
      post 'best', on: :member
    end
  end

  resources :attachments, only: [:destroy]

  mount ActionCable.server => '/cable'
end
