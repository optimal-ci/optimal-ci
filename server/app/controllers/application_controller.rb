class ApplicationController < ActionController::API
  class NotAuthorized < Exception; end

  before_action :authorize

  def authorize
    raise NotAuthorized if current_project.nil?
  end

  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  rescue_from NotAuthorized, with: :forbidden

  def unprocessable_entity
    render json: 'invalid parameters', status: :unprocessable_entity
  end

  def forbidden
    render json: 'forbidden', status: :forbidden
  end

  def current_project(lock: false)
    @current_project ||= Project.lock(lock).find_by_token(request.headers['AUTHORIZATION'])
  end

  def current_build(lock: false)
    @current_build ||= Build.lock(lock).find_by(project: current_project, build_number: params[:build_number])
  end

  def current_node(lock: false)
    @current_node ||= Node.lock(lock).find_by(build: current_build, index: params[:node_index].to_i)
  end
end
