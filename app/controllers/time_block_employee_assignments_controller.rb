class TimeBlockEmployeeAssignmentsController < ApplicationController
  def index
    render json: TimeBlockEmployeeAssignment.build(employee_id: params[:employee_id])
  end
end
