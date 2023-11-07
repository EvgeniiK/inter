class StudentSection < ApplicationRecord
  belongs_to :section
  belongs_to :student

  validate :overlap

  def overlap
    new_schedules = section.section_schedules.group_by(&:week_day)
    old_schedules = SectionSchedule.where(section_id: student.reload.student_sections.map(&:section_id)).group_by(&:week_day)
    return if old_schedules.blank?

    SectionSchedule.week_days.keys.each do |week_day|
      next if new_schedules[week_day].blank? && new_schedules[nil].blank?
      next if old_schedules[week_day].blank? && old_schedules[nil].blank?

      new_schedules.slice(week_day, nil).values.flatten.each do |new_schedule|
        overlap = new_schedule.overlap(old_schedules.slice(week_day, nil).values.flatten)

        if overlap
          return errors.add(:section_id, "You have overlap at: #{overlap.start_at_humanized} on #{overlap.week_day || new_schedule.week_day || 'Everyday'}")
        end
      end
    end
  end
end

