Rails.application.routes.draw do
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  devise_for :users
  resources :users, only: :show
  resources :exams, only: [:index, :create, :show, :update, :edit]

  authenticated :user do
    root to: "exams#index", as: "authenticated_root"
  end
  root 'static_pages#home'

  namespace :admin do
    root 'dashboards#index'
    resources :users, only: [:index, :destroy]

    resources :categories do
      resources :questions, except: :index
    end

    resources :exams, only: [:index, :destroy]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
