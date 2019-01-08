class Order < ApplicationRecord
  belongs_to :client
  has_many :order_products
  has_many :products, :through => :order_products

  STATUS_OPEN = 'OPEN'
  STATUS_STARTED = 'STARTED'
  STATUS_CONFIRMED = 'CONFIRMED'
  STATUS_READY = 'READY'
  STATUS_DELIVERY = 'DELIVERY'
  STATUS_ENDED = 'ENDED'
  STATUS_EDITABLE = [STATUS_OPEN, STATUS_STARTED]
  STATUS_FOLLOWABLE = [STATUS_OPEN, STATUS_STARTED, STATUS_CONFIRMED, STATUS_READY, STATUS_DELIVERY]

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

  def get_status
    status
  end

  def self.editable(client_id)
    Order.where(client_id: client_id, status: STATUS_EDITABLE).first    
  end
end
