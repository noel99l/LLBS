Rails.application.routes.draw do
	devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
    }
	devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
    }
    root 'homes#top'
    resources :users, only: [:show, :edit, :update]
    resources :events, only: [:show, :index] do
        get '/confirm' => 'events#confirm', as: 'confirm'
        get '/afterparty' => 'after_parties#show', as: 'party'
        resources :event_users, only: [:index, :create, :update, :destroy]
        resources :entry_tables, only: [:create,:update, :destroy]
        resources :musics, except: [:index] do
            resources :music_comments, only: [:create, :destroy]
        end
    end

    namespace :admin do
      root 'homes#top'
    end

    namespace :admin do
      resources :events
    end

    namespace :admin do
      resources :users, only: [:index, :show, :edit, :update]
    end

    namespace :admin do
      get 'entry_tables/destroy'
    end

    namespace :admin do
      get 'event_users/destroy'
    end
end