class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :name
      t.boolean :high_income
      t.boolean :upper_middle_income
      t.boolean :middle_income
      t.boolean :lower_middle_income
      t.boolean :low_income
      t.string :region

      t.timestamps
    end
  end
end
