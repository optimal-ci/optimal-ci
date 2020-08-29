class ApplicationController < ActionController::API
  class NotAuthorized < Exception; end

  before_action :authorize

  def authorize
    raise NotAuthorized if request.headers['AUTHORIZATION'] != ENV['OPTIMAL_CI_TOKEN']
  end

  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  rescue_from NotAuthorized, with: :forbidden

  def unprocessable_entity
    render json: 'invalid parameters', status: :unprocessable_entity
  end

  def forbidden
    render json: 'forbidden', status: :forbidden
  end
end
