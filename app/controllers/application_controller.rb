class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :load_client

  def add_item
    current_client = Client.find(1)
    puts params
    order_id = params["id"] || ''
    if !(order_id.is_a?(Numeric)) && order_id.empty?
      order = Order.editable(current_client.id) || []
      order = Order.create(date: Time.now, client_id: current_client.id, status: Order::STATUS_OPEN) if order.try(:empty?)
    else
      order = Order.find(order_id)
    end
    product_id = params["prod_id"] || ''
    if !product_id.empty?
      prod = Product.find(product_id)
      if prod
        @product = prod
        @order = order
      end
    end 
    render 'orders/add_item'
  end

  def add_item_confirm
    qty = params["qty"].try(:to_i)
    prod_id = params["prod_id"]
    order_id = params["order_id"]
    product = Product.find(prod_id)
    order = Order.find(order_id)
    if (qty.is_a? Numeric) && product.present? && order.present?
      orderp = OrderProduct.create(order: order, product: product, qty: qty)
      if orderp.errors.present?
        message = "Erro ao salvar produto: " + orderp.error
      else
        message = "Produto adicionado"
      end
    else 
      message = "Quantidade inválida." if !(qty.is_a? Numeric) 
      message +=  " Produto não encontrado." if !product.present? 
      message += "Pedido não encontrado" if !order.present?
    end
    respond_to do |format|  
      format.html { redirect_to orders_path, notice: message }
    end
  end

  def remove_prod_item
    prod = OrderProduct.find(params[:id])
    order = prod.order
    prod.delete
    respond_to do |format|  
      format.html { redirect_to order_path(order.id) }
    end
  end

  def confirm_order
    Order.find(params["id"]).confirm
    respond_to do |format|  
      format.html { redirect_to order_path(params["id"]) }
    end
  end

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
