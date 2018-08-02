class Course < ApplicationRecord
  validates :teacher_id, presence: true
  validates :name, presence: true
  belongs_to :teacher, class_name: "User"
  has_many :grades
end
