class DiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :new]
  before_action :find_discount, only: [:show, :edit, :update]
  def index
   
  end

  def show
    
  end

  def new

  end

  def edit

  end

  def update
    if @discount.update(discount_params)
      redirect_to merchant_discount_path(@discount.merchant_id, @discount.id)
    else
      redirect_to edit_merchant_discount_path(@discount.merchant_id, @discount.id)
      flash[:alert] = "Error: #{error_message(@discount.errors)}"
    end
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
    params.permit(:percentage_discount, :quantity_threshold)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_discount
    @discount = Discount.find(params[:id])
  end

  def error_message(errors)
   errors.full_messages.join(', ')
  end
end