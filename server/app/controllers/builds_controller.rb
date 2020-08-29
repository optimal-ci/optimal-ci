class BuildsController < ApplicationController
  def create
    Build.create!(
      queue:              params[:total_files],
      ci:                 params[:ci],
      build_number:       params[:build_number],
      total_files_count:  params[:total_files].try(:count)
    )
  end
end
