class ApplicationController < ActionController::Base
  # protect_from_forgery with: :null_session ??? do we need this?

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  private

  def record_not_found(error)
    render json: { error: error.message }, status: :not_found
  end
end
