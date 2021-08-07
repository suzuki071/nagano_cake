class Item < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  belongs_to :genres, class_name: 'Message', foreign_key: 'genre_id', optional: true
  attachment :image

end
