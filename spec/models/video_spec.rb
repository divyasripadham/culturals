require 'rails_helper'

RSpec.describe Video, type: :model do
  let(:college) {College.create!(name:"RV",address1:"airport road",city:"Bangalore",state:"Karnataka")}
  let(:event) {Event.create!(name: "TechFest", startdate: Date.today, college: college)}
  # let(:video) {Video.create!(title: "inauguration", url:"https://youtu.be/t_e24rP03mI", event: event)}
  let(:video) {event.videos.create!(title: "inauguration", url:"https://youtu.be/t_e24rP03mI")}
  it { is_expected.to belong_to(:event) }
  
  describe "attributes" do
    it "has all attributes" do
      expect(video).to have_attributes(title: "inauguration", url:"https://youtu.be/t_e24rP03mI")
    end
  end

end
