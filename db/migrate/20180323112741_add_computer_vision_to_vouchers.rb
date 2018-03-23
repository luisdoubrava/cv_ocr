class AddComputerVisionToVouchers < ActiveRecord::Migration[5.1]
  def change
    add_column :vouchers, :code_computer_vision, :string
  end
end
