Rails.application.routes.draw do
  resource :builds, only: [:create]

  get '/builds/:build_number/queue/pop' => 'builds#pop'
  post '/builds/:build_number/report' => 'builds#report'
end
