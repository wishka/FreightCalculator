# frozen_string_literal: true

class ShipmentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @shipment = Shipment.new
  end

  def index
    @shipments = if current_user.organization_admin?
                   Shipment.all.page(params[:page])
                 else
                   Shipment.where(email: current_user.email).page(params[:page])
                 end
    @shipments = @shipments.order(created_at: :desc) if params[:sort] == 'date'
    @shipments = @shipments.order(price: :asc) if params[:sort] == 'price'
    @shipments = @shipments.order(distance: :asc) if params[:sort] == 'distance'
  end

  def create
    @shipment = Shipment.new(shipment_params)
    if @shipment.save
      redirect_to @shipment
      message = 'Your shipment is successfully created!'
      SendNotifyWorker.perform_async(current_user.id, message)
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
    params.require(:shipment).permit(:first_name, :last_name, :middle_name, :phone, :email, :weight, :length, :width,
                                     :height, :origin, :destination)
  end
end
