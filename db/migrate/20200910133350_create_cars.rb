# frozen_string_literal: true

class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars, id: :uuid do |t|
      t.string :image_data, null: false
      t.string :title, null: false, index: true
      t.decimal :price, null: false, default: 0.0, precision: 8, scale: 2
      t.text :description

      t.timestamps
    end
  end
end
