class AddTypeToProducts < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :type, foreign_key: true
  end
end
