# frozen_string_literal: true

class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
    authorize @organizations

    return unless current_user.organization_admin?

    @operators = User.where(id: params[:operator_id])
    @organizations = @organizations.joins(:users).where(users: { id: @operators })
  end

  def show
    @organization = Organization.find(params[:id])
    authorize @organization
  end
end
