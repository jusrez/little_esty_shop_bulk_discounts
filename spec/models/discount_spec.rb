require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe 'validations' do
    it { should validate_numericality_of(:percentage_discount) }
    it { should validate_numericality_of(:quantity_threshold) }
  end
end