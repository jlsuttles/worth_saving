WorthSaving::Application.routes.draw do

  root to: "pages#new"

  resources :pages,  :only => [:new, :create, :edit, :update]
  resources :drafts, :only => [:new, :create, :destroy]

end
