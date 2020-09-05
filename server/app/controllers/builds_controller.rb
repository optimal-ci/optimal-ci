class BuildsController < ApplicationController
  def create
    Build.transaction do
      return head :conflict if current_build(lock: true)

      project_files = current_project.files
      total_files = params[:total_files]

      return unprocessable_entity unless total_files

      files_with_runtime = []

      total_files.each do |filename, mtime|
        key = filename + "_" + mtime

        time = if project_files[key]
                 project_files[key].to_f
               else
                 9999
               end

        files_with_runtime << [filename, time]
      end

      sorted_files = files_with_runtime.sort_by { |filanem, time| -time }.map { |f| f[0] }

      build = Build.create!(
        queue:              sorted_files,
        ci:                 params[:ci],
        build_number:       params[:build_number],
        total_files_count:  sorted_files.count,
        project:            current_project,
        command:            params[:command_arguments_string]
      )


      params[:total_nodes].to_i.times do |i|
        Node.create!(index: i, build: build)
      end
    end
  end

  def pop
    Build.transaction do
      return head :not_found if current_build.queue.empty?

      files = Array.wrap(current_build.queue.first)

      current_build.queue = current_build.queue - files
      current_build.processed += files
      current_build.save

      render json: files
    end
  end

  def report
    current_node.update(duration: params[:duration].to_i)
    current_node.update(params.permit(:http_calls_count, :http_calls_time))

    measured_files = {}
    params[:files].each do |filename, value|
      measured_files[filename + "_" + value[0]] = value[1]
    end

    Project.transaction do
      files = current_project.files
      files.merge!(measured_files)
      current_project.update(files: files)
    end
  end
end
