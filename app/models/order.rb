class Order < ApplicationRecord
    enum payment:{ credit_card: 0, transfer: 1 }
    enum status:{ a: 0, b: 1, c: 2, d: 3, e: 4 }

    belongs_to :customer
    has_many :order_details
end
