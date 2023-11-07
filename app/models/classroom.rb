class Classroom < ApplicationRecord
  has_many :sections

  validates :number, presence: true
end
