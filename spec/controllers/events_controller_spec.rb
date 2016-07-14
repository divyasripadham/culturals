require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  let(:my_college) {College.create!(name:"RV",address1:"airport road",city:"Bangalore",state:"Karnataka")}
  let(:my_event) { my_college.events.create!(name: "TechFest", startdate: Date.today) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_event] to @events" do
      get :index
      expect(assigns(:events)).to eq([my_event])
    end
  end

  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
  #
  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
