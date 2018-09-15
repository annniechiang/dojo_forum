class Reply < ApplicationRecord
  validates_presence_of :content
  
  belongs_to :user
  belongs_to :post, counter_cache: :replies_count
end
