class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :status, presence: true
  validates :importance, presence: true

  scope :desc_created, -> {order(created_at: :desc)}
  scope :asc_end_on, -> {order(end_on: :asc)}
  scope :desc_importance, -> {order(importance: :desc)}
  scope :where_like_status, -> (status) {where(['status LIKE ?', "#{status}"])}
  scope :where_like_title, -> (title) {where(['title LIKE ?', "%#{title}%"])}
  scope :where_like_status_title, -> (title, status) {where(['title LIKE ? AND status LIKE ?', "%#{title}%", "#{status}"])}
  enum importance: {低: 0,中: 1,高: 2,}
  belongs_to :user
end
