require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) { FactoryGirl.create(:userWithProject) }
  let(:project_last) { user.projects.last }

  context "DB" do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:user_id).of_type(:integer) }
  end

  context "In module" do
    it { should belong_to(:user) }
    it { should have_many(:tasks).order(position: :asc).dependent(:destroy) }
    it { should validate_presence_of(:name) }
  end

  context "Valid creation" do
    it { expect(project_last).to have_attributes(name: project_last.name) }
    it { expect(project_last).to have_attributes(user_id: user.id) }
  end  
end 