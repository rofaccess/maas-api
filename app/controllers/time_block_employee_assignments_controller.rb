class TimeBlockEmployeeAssignmentsController < ApplicationController
  def index
    render json: TimeBlockEmployeeAssignment.all
  end
end
