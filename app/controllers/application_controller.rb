class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_admin!

  layout :layout

  private
  def layout
    !devise_controller? && "application"
  end

end
