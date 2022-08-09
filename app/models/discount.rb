class Discount < ApplicationRecord
  validates :percentage_discount, presence: true, numericality: { less_than: 100 }
  validates :quantity_threshold, presence: true, numericality: true
  
  belongs_to :merchant
end