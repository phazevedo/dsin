class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def history
    @orders = Order.where(client_id: @current_client.id, status: Order::STATUS_ENDED)
    respond_to do |format|  
      format.html { render 'orders/history' }
    end    
  end

  private
  def load_client
    @current_client = Client.find_by_id(1)
  end
end
