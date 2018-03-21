class CreateVouchers < ActiveRecord::Migration[5.1]
  def change
    create_table :vouchers do |t|
      t.text :code

      t.timestamps
    end
  end
end
