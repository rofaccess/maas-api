class CompaniesController < ApplicationController
  def index
    companies = Company.all
    if companies
      render json: { status: "SUCCESS", message: "Fetched all companies successfully", data: companies }, status: :ok
    else
      render json: companies.errors, status: :bad_request
    end
  end
end
