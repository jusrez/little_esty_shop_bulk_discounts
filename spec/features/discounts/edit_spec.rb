require 'rails_helper'

RSpec.describe 'Discount Edit' do
  before :each do
    @merchant = Merchant.create!({name: "Calvin Klein"})
    @merchant_2 = Merchant.create!({name: "Hugo Boss"})
    @discount_a = Discount.create!({percentage_discount: 20, quantity_threshold: 10, merchant_id: @merchant.id})
    @discount_b = Discount.create!({percentage_discount: 30, quantity_threshold: 15, merchant_id: @merchant.id})
    @discount_c = Discount.create!({percentage_discount: 10, quantity_threshold: 2, merchant_id: @merchant_2.id})
  end
  describe 'As a merchant' do
    describe 'when I visit my bulk discount show page' do
      it 'then I see a link to tedit the bulk discount. When I click this link then i am taken to a new page with a form to edit the discount and I see that the discounts current attribute are pre populated in the form. When I change any/all of the information and click submit, then I am redirected to the bulk discounts show page and I see that the discounts attributes have been updated.' do
        
        visit merchant_discount_path(@merchant.id, @discount_a.id)

        expect(page).to have_content("Percentage Discount: 20%")
        expect(page).to have_content("Quantity Threshold: 10")

        click_link "Edit Discount"

        expect(current_path).to eq(edit_merchant_discount_path(@merchant.id, @discount_a.id))
        
        expect(page).to have_field('Percentage Discount', with: "#{@discount_a.percentage_discount}")
        expect(page).to have_field('Quantity Threshold', with: "#{@discount_a.quantity_threshold}")

        fill_in "Percentage Discount", with: "abc"
        fill_in "Quantity Threshold", with: "def"
        click_button 'Submit'

        expect(current_path).to eq(edit_merchant_discount_path(@merchant.id, @discount_a.id))
        expect(page).to have_content("Error: Percentage discount is not a number, Quantity threshold is not a number")

        fill_in "Percentage Discount", with: "25"
        fill_in "Quantity Threshold", with: "40"
        click_button 'Submit'

        expect(current_path).to eq(merchant_discount_path(@merchant.id, @discount_a.id))
        expect(page).to have_content("Percentage Discount: 25%")
        expect(page).to have_content("Quantity Threshold: 40")
      end
    end
  end
end