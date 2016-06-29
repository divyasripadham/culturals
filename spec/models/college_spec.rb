require 'rails_helper'

RSpec.describe College, type: :model do
  let(:college) {College.create!(name:"RV",address1:"airport road",city:"Bangalore",state:"Karnataka")}

  describe "attributes" do
    it "has all required attributes" do
      expect(college).to have_attributes(name:"RV",address1:"airport road",city:"Bangalore",state:"Karnataka")
    end
  end
end
