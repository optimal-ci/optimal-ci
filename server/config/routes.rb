Rails.application.routes.draw do
  resource :builds, only: [:create]

  get '/builds/:build_number/get_one_file' => 'builds#get_one_file'
end
