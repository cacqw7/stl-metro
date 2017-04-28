Rails.application.routes.draw do
  root 'stops#index'
  resources 'stops', only: [:index, :show]
end
