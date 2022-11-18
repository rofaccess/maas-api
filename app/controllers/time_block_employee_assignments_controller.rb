class TimeBlockEmployeeAssignmentsController < ApplicationController
  def index
    render json: TimeBlockEmployeeAssignment.all
  end

  def create
    TimeBlockEmployeeAssignment.save_all(assignments_params)
    render json: "Employee Assignments was saved", status: :ok
  end

  private

  def assignments_params
    params.require(:time_block_employee_assignment).permit(items: [:id, :time_block_id, :employee_id, :_destroy, :date])
  end
end
