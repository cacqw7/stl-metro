require 'rails_helper'

RSpec.describe RoutesController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    let(:route) { FactoryGirl.build_stubbed(:route) }

    before do
      allow(Route).to receive(:find).with(route.id.to_s).and_return(route)
    end

    it "returns http success" do
      get :show, params: { id: route }
      expect(response).to have_http_status(:success)
    end
  end
end
