class Voucher < ApplicationRecord
  require 'google/cloud/vision'
  require 'rtesseract'
  require 'ocr_space'
  require 'net/http'

  mount_uploader :image, VoucherImageUploader
  after_create :process_image

  def process_image
    process_image_by_google
    process_image_by_tesseract
    process_image_by_computer_vision
    save
  end

  def process_image_by_google
    vision = Google::Cloud::Vision.new
    resource = vision.image image.current_path

    self.code_google = format_code(resource.text.to_s)
  end

  def process_image_by_tesseract
    resource = RTesseract.new image.current_path, processor: 'mini_magick'
    self.code_tesseract = format_code(resource.to_s)
  end

  def process_image_by_computer_vision
    require 'net/http'

    uri = URI('https://westcentralus.api.cognitive.microsoft.com/vision/v1.0/ocr')
    uri.query = URI.encode_www_form({
      # 'detectOrientation' => 'true',
      # 'language' => 'en'
    })

    request = Net::HTTP::Post.new(uri.request_uri)
    request['Content-Type'] = 'application/octet-stream'
    request['Ocp-Apim-Subscription-Key'] = '86c29ff3270e4503bfa6769f478045dd'
    request.body = File.new(image.current_path, 'rb').read

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
    end

    if response.code == '200'
      self.code_computer_vision = format_code(response.body.scan(/"text":"(.+?)"/).join(" "))
    end
  end

  def format_code(code)
    code.delete(' ').delete("\n")
  end
end
