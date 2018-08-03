class Grade < ApplicationRecord
  validates :grade, presence: true
  validate :grade_must_be_within_range
  validates :student_id, presence: true, uniqueness: {
              scope: :course_id, message: "student can only enroll once in a class" }
  validates :course_id, presence: true
  belongs_to :student, class_name: "User"
  belongs_to :course

  private

  # validate the grade is valid on the 100pt scale
  def grade_must_be_within_range
    if !grade.nil?
      if (grade < 0)
        errors.add(:grade, "Grade must be greater than 0")
      elsif (grade > 100)
        errors.add(:grade, "Grade must be less than 100")
      end
    end
  end
end
