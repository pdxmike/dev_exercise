require 'rails_helper'

RSpec.describe Membership, type: :model do
  let(:org) { FactoryBot.create(:organization) }
  let(:user) { FactoryBot.create(:user) }
  let(:build_membership) { FactoryBot.build(:membership, organization_id: org.id, user_id: user.id) }
  let(:membership) { FactoryBot.create(:membership, organization_id: org.id, user_id: user.id) }

  context "validations" do
    it "is valid with an organization_id and user_id" do
      expect(build_membership).to be_valid
    end

    it "is invalid without an organization_id" do
      membership = FactoryBot.build(:membership, user_id: user)
      expect(membership).to_not be_valid
    end

    it "is invalid without a user_id" do
      membership = FactoryBot.build(:membership, organization_id: org)
      expect(membership).to_not be_valid
    end
  end

  context "creation" do
    it "rejects new membership of existing user/org id pairs" do
      membership
      build_membership.valid?

      expect(build_membership.errors[:organization_id]).to eq ["already has a membership with this user."]
    end
  end

  context "destruction" do
    it "is destroyed when the organization is destroyed" do
      membership

      expect(user.memberships.pluck(:id)).to include membership.id
      org.destroy
      expect(user.memberships.pluck(:id)).to_not include membership.id
      expect { membership.reload }.to raise_error ActiveRecord::RecordNotFound
    end

    it "is destroyed when the user is destroyed" do
      membership

      expect(org.memberships.pluck(:id)).to include membership.id
      user.destroy
      expect(org.memberships.pluck(:id)).to_not include membership.id
      expect { membership.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end

end
