Rails.application.routes.draw do
  devise_for :users
  
  root to: 'questions#index'

  resources :questions do 
    resources :answers, only: [:create, :update, :destroy], shallow: true do 
      post 'best', on: :member
    end
  end

  resources :attachments, only: [:destroy]
end
