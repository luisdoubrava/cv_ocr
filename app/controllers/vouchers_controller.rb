class VouchersController < ApplicationController

  skip_before_action :verify_authenticity_token # This has to be fixed, is needed for drag&drop upload but is hacky...

  def index
    @vouchers = Voucher.page(params[:page]).per(50)
  end

  def create
    (params[:image_files] || []).each do |img|
      Voucher.create(image: img)
    end
    redirect_to vouchers_path
  end

  def update
    voucher = Voucher.find(params[:id])
    voucher.update!(voucher_params)
    redirect_to vouchers_path
  end

  private

  def voucher_params
    params.require(:voucher).permit(:code)
  end
end
