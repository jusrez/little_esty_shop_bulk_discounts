class DiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :new]

  def index
   
  end

  def show
    
  end

  def new

  end

  def destroy
    Discount.find(params[:id]).destroy
    redirect_to "/merchant/#{params[:merchant_id]}/discounts"
  end

  def create
    discount = Discount.new(percentage_discount: params[:percentage_discount], quantity_threshold: params[:quantity_threshold], merchant_id: params[:merchant_id])
    if discount.save
      redirect_to merchant_discounts_path(discount.merchant_id)
    else
      flash[:alert] = "Error: #{error_message(discount.errors)}"
      redirect_to new_merchant_discount_path(discount.merchant_id)
    end
  end

  private

  def discount_params
    params.permit(:percentage_discount, :quantity_threshold, :merchant_id)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def error_message(errors)
   errors.full_messages.join(', ')
  end
end