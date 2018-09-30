class Reply < ApplicationRecord
  validates_presence_of :content
  
  belongs_to :user, counter_cache: :user_replies_count
  belongs_to :post, counter_cache: :replies_count
end
