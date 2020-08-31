Rails.application.routes.draw do
  resource :builds, only: [:create]

  get '/builds/:build_number/get_one_file' => 'builds#get_one_file'
  patch '/builds/:build_number/report_duration' => 'builds#report_duration'
end
