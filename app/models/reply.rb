class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: :replies_count
end
