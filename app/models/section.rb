class Section < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject
  belongs_to :classroom
  has_many :section_schedules, dependent: :destroy
  has_many :student_sections
  has_many :students, through: :student_sections

  validates :name, :teacher_id, :subject_id, :classroom_id, presence: true
end
