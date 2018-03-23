class VouchersController < ApplicationController
  def index
    @vouchers = Voucher.page(params[:page]).per(3)
  end

  def create
    (params[:image_files] || []).each do |img|
      Voucher.create(image: img)
    end
    redirect_to vouchers_path
  end
end
