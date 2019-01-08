class AddValueToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :total_value, :decimal
  end
end
