Turnos::Application.routes.draw do
  root "pages#home"
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"


  devise_for :users

  namespace :admin do
    root "base#index"
    resources :users
    resources :events
  end

  namespace :api do
    namespace :v1 do
      resources :events
      put "events/update", to: "events#update"
      delete "events/destroy", to: "events#destroy"
    end
  end
end
