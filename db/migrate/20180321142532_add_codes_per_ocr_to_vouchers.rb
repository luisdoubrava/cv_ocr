class AddCodesPerOcrToVouchers < ActiveRecord::Migration[5.1]
  def change
    add_column :vouchers, :code_google, :string
    add_column :vouchers, :code_tesseract, :string
    add_column :vouchers, :code_ocr_space, :string
  end
end
