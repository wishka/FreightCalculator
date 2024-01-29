# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  describe 'GET #index' do
    context 'when organization admin' do
      it 'returns a success response' do
        organization_admin = create(:user) # используем фабрику user по умолчанию
        sign_in organization_admin

        get :index

        expect(response).to be_successful
      end
    end

    context 'when operator' do
      it 'returns a success response' do
        operator = create(:user, :operator) # используем фабрику user с trait :operator
        sign_in operator

        get :index

        expect(response).to be_successful
      end
    end

    context 'with operator_id parameter' do
      it 'filters organizations by operator' do
        organization_admin = create(:user, role: :organization_admin)
        operator = create(:user, role: :operator, organization: organization_admin.organization)
        sign_in organization_admin

        get :index, params: { operator_id: operator.id }

        expect(assigns(:organizations)).to eq([organization_admin.organization])
      end
    end
  end

  describe 'GET #show' do
    context 'when organization admin' do
      it 'returns a success response' do
        organization_admin = create(:user, role: :organization_admin)
        organization = organization_admin.organization
        sign_in organization_admin

        get :show, params: { id: organization.id }

        expect(response).to be_successful
      end
    end

    context 'when operator of the organization' do
      it 'returns a success response' do
        operator = create(:user, role: :operator)
        organization = operator.organization
        sign_in operator

        get :show, params: { id: organization.id }

        expect(response).to be_successful
      end
    end

    context 'when operator of another organization' do
      it 'returns an unauthorized response' do
        operator = create(:user, role: :operator)
        organization = create(:organization)
        sign_in operator

        get :show, params: { id: organization.id }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
