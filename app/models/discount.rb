class Discount < ApplicationRecord
  validate_numericality_of :percentage_discount
  vaildate_numericality_of :quantity_threshold
  belongs_to :merchant
end