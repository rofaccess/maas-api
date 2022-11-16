class TimeBlocksController < ApplicationController
  def index
    render json: TimeBlock.all
  end
end
