class Student < ApplicationRecord
  has_many :student_sections
  has_many :sections, through: :student_sections

  validates :first_name, :email, :last_name, presence: true
  validates :email, uniqueness: true
end
