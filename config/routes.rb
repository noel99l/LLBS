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
        resources :entry_tables, only: [:update, :destroy]
        resources :musics, except: [:index] do
            resources :music_comments, only: [:create, :destroy]
        end
        post 'event_threads/confirm' => 'event_threads#confirm', as: 'threads_confirm'
        resources :event_threads, only: [:new, :create, :show, :update, :destroy] do
            resources :event_thread_comments, only: [:create, :destroy]
        end
    end

    namespace :admin do
      root 'homes#top'
    end

    namespace :admin do
      post 'events/new_confirm' => 'events#new_confirm', as: 'new_confirm'
      resources :events do
        patch 'edit_confirm' => 'events#edit_confirm', as: 'edit_confirm'
        resources :entry_tables, only: [:update]
        resources :event_users, only: [:index, :update, :destroy]
      end
    end

    namespace :admin do
      resources :users, only: [:index, :show, :edit, :update]
    end
end