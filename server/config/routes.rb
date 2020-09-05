Rails.application.routes.draw do
  resource :builds, only: [:create]

  get '/builds/:build_number/queue/pop' => 'builds#pop'
  patch '/builds/:build_number/report_duration' => 'builds#report_duration'
  patch '/builds/:build_number/report_http_calls' => 'builds#report_http_calls'
  post '/builds/:build_number/report_files' => 'builds#report_files'
end
