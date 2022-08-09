class Discount < ApplicationRecord
  validates :percentage_discount, presence: true, numericality: { less_than: 100 }
  validates :quantity_threshold, presence: true, numericality: { more_than: 0 }
  
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
end