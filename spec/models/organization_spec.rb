require 'rails_helper'

RSpec.describe Organization, type: :model do

  context "validations" do
    it "is valid with a name and description" do
      organization = FactoryBot.build(:organization)
      expect(organization).to be_valid
    end

    it "is invalid without a first_name" do
      organization = FactoryBot.build(:organization, name: nil)
      organization.valid?

      expect(organization.errors[:name]).to include("can't be blank")
    end
  end

  context "searching" do
    let!(:organization_1) { FactoryBot.create(:organization, name: "Test LLC Org", id: 1) }
    let!(:organization_2) { FactoryBot.create(:organization, name: "Potato Org", id: 2) }
    let!(:organization_3) { FactoryBot.create(:organization, name: "An LLC Organization", id: 3) }
    let!(:organization_4) { FactoryBot.create(:organization, name: "The Office", id: 4) }
    let!(:organization_5) { FactoryBot.create(:organization, name: "Swell Corgis", id: 5) }
    let(:organizations)   { Organization.all }

    it "returns all organizations on empty search" do
      expect(organizations.search_by_name("").count).to eq organizations.count
    end

    it "returns expected number of organizations when matching results found" do
      expect(organizations.search_by_name("LL").count).to eq 3
    end

    it "returns expected number organizations with lowercase input" do
      expect(organizations.search_by_name("ll").count).to eq 3
    end

    it "returns expected number organizations with mixed case input" do
      expect(organizations.search_by_name("lL").count).to eq 3
    end

    it "returns expected organizations in alphabetical order" do
      names_and_ids = organizations.search_by_name("org").pluck(:name, :id)
      expect(names_and_ids).to eq [
        ["An LLC Organization", 3],
        ["Potato Org", 2],
        ["Swell Corgis", 5],
        ["Test LLC Org", 1]
      ]
    end
  end
end
