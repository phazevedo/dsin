class Admins::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  def remove_prod_item
    prod = OrderProduct.find(params[:id])
    order = prod.order
    prod.delete
    respond_to do |format|  
      format.html { redirect_to admin_order_path(order.id) }
    end
  end

  def new_item
    @types = Type.all
    @products = Product.all
    @order = Order.find(params[:order_id])
    if @order == nil || @order == []
      respond_to do |format|  
        format.html { redirect_to admin_orders_path}
      end
    end
  end

  def add_item
    @order = Order.find(params[:order_id])
    @product = Product.find(params[:prod_id])
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
        respond_to do |format|  
          format.html { redirect_to admin_order_path(order_id), notice: message }
        end
      end
    else 
      message = "Quantidade inválida." if !(qty.is_a? Numeric) 
      message +=  " Produto não encontrado." if !product.present? 
      message += "Pedido não encontrado" if !order.present?
      respond_to do |format|  
        format.html { redirect_to admin_order_new_item_path(order_id), notice: message }
      end
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

  def prepare
    Order.find(params["id"]).prepare
    respond_to do |format|  
      format.html { redirect_to admin_order_path(params["id"]) }
    end
  end

  def ready
    Order.find(params["id"]).ready
    respond_to do |format|  
      format.html { redirect_to admin_order_path(params["id"]) }
    end
  end

  def delivery
    Order.find(params["id"]).delivery
    respond_to do |format|  
      format.html { redirect_to admin_order_path(params["id"]) }
    end
  end

  def ended
    Order.find(params["id"]).ended
    respond_to do |format|  
      format.html { redirect_to admin_order_path(params["id"]) }
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
end
