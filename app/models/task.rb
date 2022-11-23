class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline_on, presence: true
  validates :priority, presence: true
  validates :status , presence: true

  enum priority:{'高':2, '中':1, '低':0}
  enum status:{'未着手':0, '着手中':1, '完了':2}

  scope :search_status, -> (params_status){where(status: Task.statuses[params_status])}
  scope :search_title, -> (params_title){where('title LIKE ?', "%#{params_title}%")}
  scope :default_order, -> {order("created_at DESC")}
  scope :deadline, -> {order("deadline_on ASC")}
  scope :priority, -> {order("priority DESC")}

  belongs_to :user
  has_many :group_tasks, dependent: :destroy
  has_many :labels, through: :group_tasks
end