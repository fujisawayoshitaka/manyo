class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  scope :search_title, ->(title) { where(title: title) }
end
