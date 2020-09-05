class BuildsController < ApplicationController
  def create
    Build.transaction do
      return head :conflict if current_build

      build = Build.create!(
        queue:              params[:total_files],
        ci:                 params[:ci],
        build_number:       params[:build_number],
        total_files_count:  params[:total_files].try(:count),
        project:            current_project,
        command:            params[:command_arguments_string]
      )

      params[:total_nodes].to_i.times do |i|
        Node.create!(index: i, build: build)
      end
    end
  end

  def get_one_file
    Build.transaction do
      return head :not_found if current_build.queue.empty?

      files = Array.wrap(current_build.queue.first)

      current_build.queue = current_build.queue - files
      current_build.processed += files
      current_build.save

      render json: files
    end
  end

  def report_duration
    current_node.update(duration: params[:duration])
  end

  def report_http_calls
    current_node.update(params.permit(:http_calls_count, :http_calls_time))
  end
end
