class AddImageToVouchers < ActiveRecord::Migration[5.1]
  def change
    add_column :vouchers, :image, :string
  end
end
