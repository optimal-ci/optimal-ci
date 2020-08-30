class BuildsController < ApplicationController
  def create
    Build.transaction do
      return head :conflict if Build.find_by_build_number(params[:build_number])

      Build.create!(
        queue:              params[:total_files],
        ci:                 params[:ci],
        build_number:       params[:build_number],
        total_files_count:  params[:total_files].try(:count)
      )
    end
  end

  def get_one_file
    Build.transaction do
      build = Build.find_by_build_number(params[:build_number])

      return head :not_found if build.queue.empty?

      files = Array.wrap(build.queue.first)

      build.queue = build.queue - files
      build.processed += files
      build.save

      render json: files
    end
  end
end
