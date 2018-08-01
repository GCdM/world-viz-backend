class CreateFlows < ActiveRecord::Migration[5.2]
  def change
    create_table :flows do |t|
      t.integer :origin_id
      t.integer :destination_id
      t.integer :quantity
      t.integer :year

      t.timestamps
    end
  end
end
