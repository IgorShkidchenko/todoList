require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:userWithProject) }

  context "DB" do
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:encrypted_password).of_type(:string) }
  end

  context "In module" do
    it { should have_many(:projects).dependent(:destroy) }
    it { should have_many(:tasks).through(:projects) }
  end

  context "Valid creation" do
    it { expect(user).to have_attributes(email: user.email) }
    it { expect(user).to have_attributes(id: user.projects.last.user_id) }
  end
end