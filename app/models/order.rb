class Order < ApplicationRecord
  belongs_to :client
  has_many :order_products
  has_many :products, :through => :order_products

  STATUS_OPEN = 'OPEN'
  STATUS_STARTED = 'STARTED'
  STATUS_CONFIRMED = 'CONFIRMED'
  STATUS_PREPARE = 'PREPARE'
  STATUS_READY = 'READY'
  STATUS_DELIVERY = 'DELIVERY'
  STATUS_ENDED = 'ENDED'
  STATUS_EDITABLE = [STATUS_OPEN, STATUS_STARTED]
  STATUS_FOLLOWABLE = [STATUS_OPEN, STATUS_STARTED, STATUS_CONFIRMED, STATUS_READY, STATUS_DELIVERY, STATUS_PREPARE ]

  def self.opened(client_id)
    Order.where(client_id: client_id, status: STATUS_OPEN).first
  end

  def value
    val = 0
    OrderProduct.where(order_id: id).each do |prod|
      val += prod.product.price * prod.qty
    end
    val
  end

  def confirm
    update(status: STATUS_STARTED) if status == STATUS_OPEN
  end

  def prepare
    update(status: STATUS_PREPARE) if status == STATUS_STARTED
  end

  def ready
    update(status: STATUS_READY) if status == STATUS_PREPARE
  end

  def ended
    nil unless status == STATUS_DELIVERY
    update(status: STATUS_ENDED, total_value: value) 
  end

  def delivery
    update(status: STATUS_DELIVERY) if status == STATUS_READY
  end

  def get_status
    case status
    when (STATUS_OPEN)
       'Aberto  '
    when (STATUS_STARTED)
       'Esperando confirmação'
    when (STATUS_CONFIRMED)
       'Confirmado'
    when (STATUS_PREPARE)
       'Em preparo'
    when (STATUS_READY)
       'Pronto'
    when (STATUS_DELIVERY)
       'Saiu pare entrega'
    when (STATUS_ENDED)
       'Encerrado'
    else
      'Cancelado'
    end
  end

  def self.editable(client_id)
    Order.where(client_id: client_id, status: STATUS_EDITABLE).first    
  end
end
