require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:college) {College.create!(name:"RV",address1:"airport road",city:"Bangalore",state:"Karnataka")}
  # let(:event) {Event.create!(name: "TechFest", startdate: Date.today, college: college)}
  let(:event) { college.events.create!(name: "TechFest", startdate: Date.today) }
  it { is_expected.to belong_to(:college) }
  
  describe "attributes" do
    it "has all attributes" do
      expect(event).to have_attributes(name: "TechFest", startdate: Date.today)
    end
  end
end
