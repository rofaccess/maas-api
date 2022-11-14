class WeeklyMonitoringCalendarsController < ApplicationController
  def index
    render json: WeeklyMonitoringCalendar.where(monitored_service_id: params[:monitored_service_id])
  end
end
