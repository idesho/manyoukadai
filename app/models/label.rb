class Label < ApplicationRecord
    validates :name, presence: true

  has_many :group_tasks, dependent: :destroy
  has_many :tasks, through: :group_tasks
  belongs_to :user
end
