class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity


  def unprocessable_entity
    render json: 'invalid parameters', status: :unprocessable_entity
  end
end
