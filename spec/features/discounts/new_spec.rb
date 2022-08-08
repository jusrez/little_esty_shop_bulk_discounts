require 'rails_helper'

RSpec.describe 'Discount Create' do
  before :each do
    @merchant = Merchant.create!({name: "Calvin Klein"})
    @merchant_2 = Merchant.create!({name: "Hugo Boss"})
    @discount_a = Discount.create!({percentage_discount: 20, quantity_threshold: 10, merchant_id: @merchant.id})
    @discount_b = Discount.create!({percentage_discount: 30, quantity_threshold: 15, merchant_id: @merchant.id})
    @discount_c = Discount.create!({percentage_discount: 10, quantity_threshold: 2, merchant_id: @merchant_2.id})
  end

  describe 'As a merchant' do
    describe 'when I visit my bulk discounts index I see a link to create a new discount.' do
      describe 'When I click this link then i am taken to a new page where i see a form to add a new bulk discount.' do
        it 'When I fill in the form with valid data then I am redirected back to the bulk discount index and I see my new bulk discount listed' do

          visit "/merchant/#{@merchant.id}/discounts"
          
          expect(page).to have_link("Create New Discount")

          click_link("Create New Discount")

          expect(current_path).to eq("/merchant/#{@merchant.id}/discounts/new")

          fill_in "Percentage Discount", with: "not a number"
          fill_in "Quantity Threshold", with: "also not a number"
          click_button 'Submit'

          expect(current_path).to eq("/merchant/#{@merchant.id}/discounts/new")
          expect(page).to have_content("Error: Percentage discount is not a number, Quantity threshold is not a number")
          
          fill_in "Percentage Discount", with: 15
          fill_in "Quantity Threshold", with: 5
          click_button 'Submit'

          expect(current_path).to eq("/merchant/#{@merchant.id}/discounts")
           
          within "#discount-#{@merchant.discounts.last.id}" do
            expect(page).to have_content("Percentage Discount: 15%")
            expect(page).to have_content("Quantity Threshold: 5")
          end
        end 
      end
    end
  end
end