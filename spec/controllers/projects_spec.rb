require 'rails_helper'

describe ProjectsController, :type => :controller  do
  let(:user) { FactoryGirl.create(:userWithProject) }
  let(:projectName) { user.projects.last.name }
  let(:projectUserId) { user.projects.last.user_id }
  let(:projectId) { user.projects.last.id }
  
  before :each do
    sign_in(user) 
  end 

  it "Valid factory test" do
    expect(user.id).to eq (projectUserId)
  end

  it "New project" do
    get :new, xhr: true
    expect(response).to have_http_status(:success)
    expect(response).to render_template(:new)
  end

  it "Create project" do
    expect {
      post :create,xhr: true, params: { project: { name: projectName } }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:create)
      expect(flash[:success]).to eq "Project created!"
    }.to change(Project, :count).by(1)
  end

  it "Edit project" do
    get :edit, xhr: true, params: { user_id: projectUserId, id: projectId }
    expect(response).to have_http_status(:success)
    expect(response).to render_template(:edit)
  end

  it "Update project" do
    patch :update, xhr: true, params: { user_id: projectUserId, id: projectId, project: { name: 'newProject' } }
    expect(response).to have_http_status(:success)
    expect(response).to render_template(:update)
    expect(flash[:success]).to eq "Project updated!"
    expect(projectName).to eq "newProject"
  end

  it "Delete project" do
    expect {
      delete :destroy, xhr: true, params: { user_id: projectUserId, id: projectId }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:destroy)
      expect(flash[:danger]).to eq "Project deleted!" 
    }.to change(Project, :count).by(-1)
  end

  it "Create with empty project name" do
    expect {
      post :create, xhr: true, params: { project: { name: '' } }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:valid)
      expect(flash[:danger]).to eq "Can't be blank!"
    }.to change(Project, :count).by(0)
  end

  it "Update with empty project name" do
    patch :update, xhr: true, params: { user_id: projectUserId, id: projectId, project: { name: '' } }
    expect(response).to have_http_status(:success)
    expect(response).to render_template(:valid)
    expect(flash[:danger]).to eq "Can't be blank!"
    expect(projectName).to eq (projectName)
  end

  context "Test routes" do
    it { should route(:get, '/projects/new').to(action: :new) }
    it { should route(:post, '/projects').to(action: :create) }
    it { should route(:get, '/projects/1/edit').to(action: :edit, id: 1) }
    it { should route(:patch, '/projects/1').to(action: :update, id: 1) }
    it { should route(:delete, '/projects/1').to(action: :destroy, id: 1) }
  end
end