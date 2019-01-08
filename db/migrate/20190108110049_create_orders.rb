class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.datetime :date
      t.text :obs
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
