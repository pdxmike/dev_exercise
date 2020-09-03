require 'rails_helper'

RSpec.describe Membership, type: :model do
  let(:org) { FactoryBot.create(:organization) }
  let(:user) { FactoryBot.create(:user) }

  it "is valid with an organization_id and user_id" do
    membership = FactoryBot.build(:membership, organization_id: org.id, user_id: user.id)
    expect(membership).to be_valid
  end

  it "is invalid without an organization_id" do
    membership = FactoryBot.build(:membership, user_id: user)
    expect(membership).to_not be_valid
  end

  it "is invalid without a user_id" do
    membership = FactoryBot.build(:membership, organization_id: org)
    expect(membership).to_not be_valid
  end

  it "is destroyed when the organization is destroyed" do
    membership = FactoryBot.create(:membership, organization_id: org.id, user_id: user.id)

    expect(user.memberships.pluck(:id)).to include membership.id
    org.destroy
    expect(user.memberships.pluck(:id)).to_not include membership.id
  end

  it "is destroyed when the user is destroyed" do
    membership = FactoryBot.create(:membership, organization_id: org.id, user_id: user.id)

    expect(org.memberships.pluck(:id)).to include membership.id
    user.destroy
    expect(org.memberships.pluck(:id)).to_not include membership.id
  end

  context "when existing" do
    it "rejects new membership of existing user/org id pairs" do
      membership = FactoryBot.create(:membership, organization_id: org.id, user_id: user.id)
      membership2 = FactoryBot.build(:membership, organization_id: org.id, user_id: user.id)
      membership2.valid?

      expect(membership2.errors[:organization_id]).to eq ["already has a membership with this user."]
    end
  end
end
