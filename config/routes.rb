Rails.application.routes.draw do

  namespace :support_form, path: "" do
    resources :stats
  end
end
