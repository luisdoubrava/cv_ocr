class Voucher < ApplicationRecord
  require 'google/cloud/vision'

  mount_uploader :image, VoucherImageUploader
  # after_create :process_image

  def process_image
    vision = Google::Cloud::Vision.new
    image = vision.image self.image.url

    self.code = image.text
  end
end
