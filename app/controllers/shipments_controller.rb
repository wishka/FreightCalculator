class ShipmentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @shipment = Shipment.new
  end

  def index
    @shipments = Shipment.where(email: current_user.email).page(params[:page])
  end

  def create
    @shipment = Shipment.new(shipment_params)
    if @shipment.save
      redirect_to @shipment
    else
      render :new
    end
  end

  def show
    @shipment = Shipment.find(params[:id])
    @price = @shipment.calculate_price
  end

  private

  def shipment_params
    params.require(:shipment).permit(:first_name, :last_name, :middle_name, :phone, :email, :weight, :length, :width, :height, :origin, :destination)
  end
end