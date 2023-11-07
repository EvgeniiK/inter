class StudentSectionsController < ApplicationController
  before_action :set_student_section, only: :destroy

  # GET /students_sections
  # GET /students_sections.json
  # GET /students_sections.pdf
  def index
    @student_section = current_student.student_sections.new
    set_variables
  end

  def create
    @student_section = current_student.student_sections.new(student_section_params)

    if @student_section.save
      flash[:notice] = 'Section was successfully added'
      @student_section = current_student.student_sections.new
    end
    set_variables
    render :index
  end

  def destroy
    @student_section.destroy!
    flash[:notice] = 'You were successfully removed from the section'
    @student_section = current_student.student_sections.new
    set_variables
    render :index
  end

  def student_section_params
    params.require(:student_section).permit(:section_id)
  end

  def set_student_section
    @student_section = StudentSection.find(params[:id])
  end

  # NOTE: It is a stub just for demo purposes
  def current_student
    Student.first
  end

  def set_variables
    @section_schedules  = SectionSchedule.includes(section: [:teacher, :classroom, :subject]).group_by(&:week_day)
    @assigned_sections  = Section.joins(:student_sections).where(student_sections: { student_id: current_student }).includes(:teacher, :classroom, :subject)
    @student_sections   = StudentSection.where(student_id: current_student.id).includes(:section)
    @available_sections = Section.where.not(id: @student_sections.map(&:section_id))
  end
end
