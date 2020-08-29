Rails.application.routes.draw do
  resource :builds, only: [:create]
end
