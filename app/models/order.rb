class Order < ApplicationRecord
  
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  
  #注文の全ての数量合計
  def sum_order_items
    self.order_items.all.sum(:amount)
  end

  #注文の合計金額
  def total_payment
    array = []
    self.order_items.each do |order_item|
       array << order_item.price * order_item.amount
   end
    array.sum
  end
  
  enum payment_method: { クレジットカード: 0, 銀行振込: 1}
  enum status: { 入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4}
  
end
