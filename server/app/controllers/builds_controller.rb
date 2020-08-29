class BuildsController < ApplicationController
  def create
    Build.create!(
      queue:              params[:total_files],
      total_files_count:  params[:total_files].count,
      ci:                 params[:ci],
      build_number:       params[:build_number]
    )
  end
end
