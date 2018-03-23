class Voucher < ApplicationRecord
  require 'google/cloud/vision'
  require 'rtesseract'
  require 'ocr_space'

  mount_uploader :image, VoucherImageUploader
  after_create :process_image

  def process_image
    # process_image_by_google
    process_image_by_tesseract
    process_image_by_ocr_space
    save
  end

  def process_image_by_google
    vision = Google::Cloud::Vision.new
    resource = vision.image image.current_path

    self.code_google = resource.text
  end

  def process_image_by_tesseract
    resource = RTesseract.new image.current_path, processor: 'mini_magick'
    self.code_tesseract = resource.to_s
  end

  def process_image_by_ocr_space
    resource = OcrSpace::Resource.new(apikey: ENV['OCR_API_KEY'])
    result = resource.convert file: image.current_path
    self.code_ocr_space = result.try(:[], 'ParsedText')
  end
end
