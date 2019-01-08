class CreateOrderProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :order_products do |t|
      t.references :product, foreign_key: true
      t.references :order, foreign_key: true
      t.integer :qty

      t.timestamps
    end
  end
end
