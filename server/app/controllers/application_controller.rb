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

  def current_project
    @current_project ||= Project.find_by_token(request.headers['AUTHORIZATION'])
  end
end
