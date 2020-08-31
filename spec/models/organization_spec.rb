require 'rails_helper'

RSpec.describe Organization, type: :model do
  it "is valid with a name and description" do
    organization = FactoryBot.build(:organization)
    expect(organization).to be_valid
  end

  it "is invalid without a first_name" do
    organization = FactoryBot.build(:organization, name: nil)
    organization.valid?

    expect(organization.errors[:name]).to include("can't be blank")
  end

  context "Searching" do
    let!(:organization_1) { FactoryBot.create(:organization, name: "Test LLC Org") }
    let!(:organization_2) { FactoryBot.create(:organization, name: "Potato Org") }
    let!(:organization_3) { FactoryBot.create(:organization, name: "An LLC Organization") }
    let!(:organization_4) { FactoryBot.create(:organization, name: "The Office") }
    let!(:organization_5) { FactoryBot.create(:organization, name: "Wellness Organization") }

    it "returns all organizations on empty search" do
      filtered = Organization.search_by_name("").count
      expect(filtered).to eq Organization.count
    end

    it "returns expected number of organizations when matching results found" do
      filtered = Organization.search_by_name("LL").count
      expect(filtered).to eq 3
    end

    it "returns expected number organizations with lowercase input" do
      filtered = Organization.search_by_name("ll").count
      expect(filtered).to eq 3
    end

    it "returns expected number organizations with mixed case input" do
      filtered = Organization.search_by_name("lL").count
      expect(filtered).to eq 3
    end
  end
end
