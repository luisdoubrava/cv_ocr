class VouchersController < ApplicationController
  def index
    @voucher = Voucher.all
  end

  def create
    (params[:image_files] || []).each do |img|
      @voucher = Voucher.create(image: img)
    end
  end
end
