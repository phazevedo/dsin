class Clients::ClientsController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :authenticate_client!

    layout 'client'
end
  