require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { FactoryGirl.create(:userWithProject) }
  let(:projectTask) { user.projects.last.tasks.create(content: 'Task')}

  context "DB" do
    it { should have_db_column(:content).of_type(:string) }
    it { should have_db_column(:project_id).of_type(:integer) }
    it { should have_db_column(:complete).of_type(:boolean) }
    it { should have_db_column(:position).of_type(:integer) }
    it { should have_db_column(:deadline).of_type(:date) }
  end

  context "In module" do
    it { should belong_to(:project) }
    it { should validate_presence_of(:content).with_message("can't be blank!") }
    it { should validate_length_of(:content).is_at_most(65).with_message("is too long!") }
  end

  context "Valid creation" do
    it { expect(projectTask).to have_attributes(content: 'Task') }
    it { expect(projectTask).to have_attributes(project_id: user.projects.last.id) }
    it { expect(projectTask).to have_attributes(complete: false) }
    it { expect(projectTask).to have_attributes(position: 1) }
    it { expect(projectTask).to have_attributes(deadline: nil) }
  end
end