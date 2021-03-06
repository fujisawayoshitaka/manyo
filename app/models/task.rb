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
  scope :label_name_search, -> (label_search) {Task.joins(:labels).where(['labels.title LIKE ?', "%#{label_search}%"])}
  #scope :where_like_label, -> (title) {labels.where(['label LIKE ?', "#{title}"])}
  scope :where_like_status_title, -> (title, status) {where(['title LIKE ? AND status LIKE ?', "%#{title}%", "#{status}"])}
  enum importance: {低: 0,中: 1,高: 2,}
  belongs_to :user, optional: true
  has_many :task_labels, dependent: :destroy, foreign_key: 'task_id'
  has_many :labels, through: :task_labels, source: :label
end
