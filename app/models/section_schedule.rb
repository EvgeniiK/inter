class SectionSchedule < ApplicationRecord
  START_AT = 730
  END_AT = 2200
  DEFAULT_DURATION = 50

  belongs_to :section

  validates :start_at, :end_at, presence: true
  validate :start_before_end
  validate :begining
  validate :ending

  # INFO: If nil - every day
  enum week_day: Date::DAYNAMES[1..5].inject({}) { |h, name| h.merge!(name => name) }

  def duration
    ((end_at - start_at) / 60).to_i
  end

  def start_at_humanized
    start_at.strftime('%H:%M')
  end

  def overlap(schedules)
    schedules.each do |schedule|
      return schedule if schedule.start_at.strftime('%H%M').to_i.between?(start_at.strftime('%H%M').to_i, end_at.strftime('%H%M').to_i)
      return schedule if schedule.end_at.strftime('%H%M').to_i.between?(start_at.strftime('%H%M').to_i, end_at.strftime('%H%M').to_i)
    end
    nil
  end

  private

  def start_before_end
    (end_at - start_at).positive?
  end

  def begining
    errors.add(:start_at, 'too early or too late') unless start_at.strftime('%H%M').to_i.between?(START_AT, END_AT - DEFAULT_DURATION)
  end

  def ending
    errors.add(:end_at,'too late or too late') unless end_at.strftime('%H%M').to_i.between?(START_AT, END_AT)
  end
end
