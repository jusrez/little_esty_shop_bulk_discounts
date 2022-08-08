require 'rails_helper'

RSpec.describe 'Discount Show' do
  before :each do
   @merchant = Merchant.create!({name: "Calvin Klein"})
   @merchant_2 = Merchant.create!({name: "Hugo Boss"})
   @discount_a = Discount.create!({percentage_discount: 20, quantity_threshold: 10, merchant_id: @merchant.id})
   @discount_b = Discount.create!({percentage_discount: 30, quantity_threshold: 15, merchant_id: @merchant.id})
   @discount_c = Discount.create!({percentage_discount: 10, quantity_threshold: 2, merchant_id: @merchant_2.id})
  end
  describe 'As a merchant' do
    describe 'When I visit my bulk discount show page' do
      it 'then I see the bulk discounts quantity threshold and percentage discount' do
        
        visit merchant_discount_path(@merchant, @discount_a)
        
        expect(page).to have_content("Percentage Discount: 20%")
        expect(page).to have_content("Quantity Threshold: 10")
      end
    end
  end
end