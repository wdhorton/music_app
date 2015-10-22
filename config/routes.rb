Rails.application.routes.draw do
  root 'sessions#new'

  resources :users, only: [:create, :new, :show] do
    collection do
      get 'activate'
    end
  end

  resource :session, only: [:create, :new, :destroy]

  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, except: [:new, :index] do
    resources :tracks, only: [:new]
  end

  resources :tracks, except: [:new, :index]

  resources :notes, except: [:new, :index]
end
