class EmployeesController < ApplicationController
  def index
    render json: Employee.all
  end

  def assignments
    render json: Employee.time_block_assignments(params[:id], params[:start_date], params[:end_date])
  end
end
