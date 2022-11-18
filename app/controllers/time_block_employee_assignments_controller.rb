class TimeBlockEmployeeAssignmentsController < ApplicationController
  def index
    render json: TimeBlockEmployeeAssignment.buildTimeBlockEmployeeAssignments(employee_id: params[:employee_id])
  end
end
