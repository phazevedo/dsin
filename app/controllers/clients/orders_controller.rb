class Clients::OrdersController < Clients::ClientsController
    protect_from_forgery with: :exception
    before_action :set_order, only: [:show, :edit, :update, :destroy, :order_again]
    before_action :verify_order, only: [:show, :edit, :update, :destroy]

  
    def index
        @orders = Order.all
        @types = Type.all
        @products = Product.all
        @most_buyed_id = OrderProduct.joins(:order, :product).where(orders: {status: Order::STATUS_ENDED}).group("order_products.product_id").sum("order_products.qty").max_by{|k,v| v}.first
    end

    def add_item
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
      render 'clients/orders/add_item'
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
        format.html { redirect_to client_orders_path, notice: message }
      end
    end
  
    def remove_prod_item
      prod = OrderProduct.find(params[:id])
      order = prod.order
      prod.delete
      respond_to do |format|  
        format.html { redirect_to client_order_path(order.id) }
      end
    end
  
    def confirm_order
      Order.find(params["id"]).confirm
      respond_to do |format|  
        format.html { redirect_to client_order_path(params["id"]) }
      end
    end
  
    def history
      @orders = Order.where(client_id: current_client.id, status: Order::STATUS_ENDED)
      respond_to do |format|  
        format.html { render 'clients/orders/history' }
      end    
    end

    def order_again
      new_order = Order.editable(current_client.id) || []
      new_order = Order.create(date: Time.now, client_id: current_client.id, status: Order::STATUS_OPEN) if new_order.try(:empty?)
      @order.order_products.each do |op|
        new_op = op.dup
        new_op.order_id = new_order.id
        new_op.save
      end
      respond_to do |format|  
        format.html { redirect_to client_order_path(new_order.id) }
      end    
    end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:date, :obs, :client_id)
    end

    def verify_order
      return nil if @order.client_id == current_client.id
      respond_to do |format|
        format.html { redirect_to client_orders_url, notice: 'Pedido inexistente' }
        format.json { head :no_content }
      end
    end
  end
  