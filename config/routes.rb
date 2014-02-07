Rails.application.routes.draw do

  namespace :support_form, path: "" do
    resources :stats
    resources :enquiries, only: [:new, :create]
  end
end
