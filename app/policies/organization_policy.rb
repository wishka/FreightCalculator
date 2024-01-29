# frozen_string_literal: true

class OrganizationPolicy < ApplicationPolicy
  def index?
    user.organization_admin?
  end

  def show?
    user.organization_admin? || (user.operator? && user.organization == record)
  end
end
