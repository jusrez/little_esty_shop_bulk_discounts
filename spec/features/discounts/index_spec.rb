require 'rails_helper'

RSpec.describe 'Discounts Index' do
  before :each do
    @merchant = Merchant.create!({name: "Calvin Klein"})
    @merchant_2 = Merchant.create!({name: "Hugo Boss"})
    @discount_a = Discount.create!({percentage_discount: 20, quantity_threshold: 10, merchant_id: @merchant.id})
    @discount_b = Discount.create!({percentage_discount: 30, quantity_threshold: 15, merchant_id: @merchant.id})
    @discount_c = Discount.create!({percentage_discount: 10, quantity_threshold: 2, merchant_id: @merchant_2.id})

  end
  describe 'As a merchant' do
    describe 'When I visit my merchant dashboard then i see a link to view all my discounts' do
      describe 'when i click this link then i am taken to my bulk discounts index page' do
        it 'where i see all of my bulk discounts including their perentage discount and quantity thresholds and each bulk discount listed includes a link to it show page' do

          visit "/merchant/#{@merchant.id}/dashboard"

          expect(page).to have_link("Discounts")

          click_link "Discounts"

          expect(current_path).to eq("/merchant/#{@merchant.id}/discounts")

          within "#discount-#{@discount_a.id}" do
            expect(page).to have_content("Percentage Discount: 20%")
            expect(page).to have_content("Quantity Threshold: 10")
            expect(page).to_not have_content("Percentage Discount: 10%")
            expect(page).to_not have_content("Percentage Discount: 30%")
          end

          within "#discount-#{@discount_b.id}" do
            expect(page).to have_content("Percentage Discount: 30%")
            expect(page).to have_content("Quantity Threshold: 15")
            expect(page).to_not have_content("Percentage Discount: 10%")
            expect(page).to_not have_content("Percentage Discount: 20%")
          end

          expect(page).to have_link("Discount ##{@discount_a.id}")
          expect(page).to have_link("Discount ##{@discount_b.id}")
          expect(page).to_not have_link("Discount ##{@discount_c.id}")

          click_link "Discount ##{@discount_a.id}"

          expect(current_path).to eq("/merchant/#{@merchant.id}/discounts/#{@discount_a.id}")
        end

        it 'then next to each bulk discount i see a link to delete it. When i click this link then i am redirected back to the bulk discounts index page and i no longer see the discount listed' do

          visit merchant_discounts_path(@merchant)
          save_and_open_page
          within "#discount-#{@discount_a.id}" do
            expect(page).to have_link("Delete Discount")
          end

          within "#discount-#{@discount_b.id}" do
            expect(page).to have_link("Delete Discount")
          end

          within "#discount-#{@discount_a.id}" do
            click_link "Delete Discount"
          end
          save_and_open_page 
          expect(current_path).to eq("/merchant/#{@merchant.id}/discounts")
          expect(page).to_not have_content("#{@discount_a.id}")
          expect(page).to_not have_content("#{@discount_a.percentage_discount}")
          expect(page).to_not have_content("#{@discount_a.quantity_threshold}")
          
        end
      end
    end
  end
end