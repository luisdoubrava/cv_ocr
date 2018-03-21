class Voucher < ApplicationRecord
  mount_uploader :image, VoucherImageUploader
end
