# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShipmentsController, type: :controller do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, organization_admin: true) }

  describe 'GET #new' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'renders the new template' do
        get :new
        expect(response).to render_template :new
      end

      it 'assigns a new shipment to @shipment' do
        get :new
        expect(assigns(:shipment)).to be_a_new(Shipment)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in page' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #index' do
    context 'when user is an organization admin' do
      before { sign_in admin_user }

      it 'assigns all shipments to @shipments' do
        get :index
        expect(assigns(:shipments)).to eq(Shipment.all)
      end
    end

    context 'when user is not an organization admin' do
      before { sign_in user }

      it "assigns the user's shipments to @shipments" do
        user_shipments = create_list(:shipment, 3, email: user.email)
        other_user_shipments = create_list(:shipment, 2, email: 'other@example.com')
        get :index
        expect(assigns(:shipments)).to match_array(user_shipments)
        expect(assigns(:shipments)).not_to match_array(other_user_shipments)
      end
    end

    it "orders shipments by date when 'sort' parameter is 'date'" do
      sign_in user
      create_list(:shipment, 3)
      get :index, params: { sort: 'date' }
      expect(assigns(:shipments)).to eq(Shipment.order(created_at: :desc))
    end

    it "orders shipments by price when 'sort' parameter is 'price'" do
      sign_in user
      create_list(:shipment, 3)
      get :index, params: { sort: 'price' }
      expect(assigns(:shipments)).to eq(Shipment.order(price: :asc))
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new shipment' do
        sign_in user
        expect do
          post :create, params: { shipment: attributes_for(:shipment) }
        end.to change(Shipment, :count).by(1)
      end

      it 'redirects to the created shipment' do
        sign_in user
        post :create, params: { shipment: attributes_for(:shipment) }
        expect(response).to redirect_to(Shipment.last)
      end

      it 'sends a notification to the user' do
        expect(SendNotifyWorker).to receive(:perform_async).with(user.id, 'Your shipment is successfully created!')
        sign_in user
        post :create, params: { shipment: attributes_for(:shipment) }
      end
    end

    context 'with invalid params' do
      it 'renders the new template' do
        sign_in user
        post :create, params: { shipment: { first_name: '' } }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested shipment as @shipment' do
      get :show, params: { id: shipment.to_param }
      expect(assigns(:shipment)).to eq(shipment)
    end

    it 'calculates the shipment price' do
      expect(shipment).to receive(:calculate_price)
      get :show, params: { id: shipment.to_param }
    end
  end
end

RSpec.describe ShipmentsController do
  describe 'strong parameters' do
    it 'permits the required shipment attributes' do
      should permit(:first_name, :last_name, :middle_name, :phone, :email, :weight, :length, :width, :height, :origin, :destination)
        .for(:shipment, on: :create)
    end
  end
end
