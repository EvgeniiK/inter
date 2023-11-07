class SectionsController < ApplicationController
  def index
    @sections = Section.includes(:teacher, :classroom, :subject).all
  end
end
