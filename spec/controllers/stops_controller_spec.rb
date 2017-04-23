require 'rails_helper'

RSpec.describe StopsController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    let(:stop) { FactoryGirl.build_stubbed(:stop) }

    before do
      allow(Stop).to receive(:find).with(stop.id.to_s).and_return(stop)
    end

    it "returns http success" do
      get :show, params: { id: stop }
      expect(response).to have_http_status(:success)
    end
  end
end
