class CreateProductIngrendients < ActiveRecord::Migration[5.0]
  def change
    create_table :product_ingrendients do |t|
      t.references :product, foreign_key: true
      t.references :ingredient, foreign_key: true

      t.timestamps
    end
  end
end
