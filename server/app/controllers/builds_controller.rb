class BuildsController < ApplicationController
  def create
    Build.create!(
      queue:              params[:total_files],
      ci:                 params[:ci],
      build_number:       params[:build_number],
      total_files_count:  params[:total_files].try(:count)
    )
  end

  def get_one_file
    build = Build.find_by_build_number(params[:build_number])

    return head :not_found if build.queue.empty?

    files = Array.wrap(build.queue.first)

    build.queue = build.queue - files
    build.save

    render json: files
  end
end
