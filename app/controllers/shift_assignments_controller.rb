class ShiftAssignmentsController < ApplicationController
  def index
    render json: ShiftAssignment.time_block_assignments(params[:monitored_service_id],
                                                        params[:start_date],
                                                        params[:end_date])
  end
end
