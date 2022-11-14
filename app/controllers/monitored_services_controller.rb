class MonitoredServicesController < ApplicationController
  def index
    render json: MonitoredService.where(company_id: params[:company_id])
  end
end
