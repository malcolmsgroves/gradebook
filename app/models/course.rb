class Course < ApplicationRecord
  validates :teacher_id, presence: true
  validates :name, presence: true
  belongs_to :teacher, class_name: "User"
  has_many :grades

  # Efficient SQL that plucks each course name
  # along with the enrollment count and average
  # grade for each course
  def self.course_listing
    self.all
      .joins(:grades)
      .group(:id)
      .pluck(:name,
             Arel.sql('count(grades.id)'),
             Arel.sql('avg(grades.grade)'))
  end
end
