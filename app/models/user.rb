class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :taught_courses, class_name: "Course", foreign_key: :teacher_id
  has_many :grades, foreign_key: :student_id
  has_many :courses, through: :grades, source: :course
end
