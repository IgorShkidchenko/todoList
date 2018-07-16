require 'rails_helper'

describe TasksController, :type => :controller  do
  let(:user) { FactoryGirl.create(:userWithProject) }
  let(:projectId) { user.projects.last.id }
  let(:projectTask) { user.projects.last.tasks.create(content: 'Task')}
  let(:lastTask) { user.projects.last.tasks.last }
  
  before :each do
    sign_in(user)
  end 

  it "Valid factory test" do
    expect(projectTask.project_id).to eq (projectId)
  end

  it "New task" do
    get :new, xhr: true, params: { project_id: projectId }
    expect(response).to have_http_status(:success)
    expect(response).to render_template(:new)
  end

  it "Create task" do
    expect {
      post :create,xhr: true, params: { project_id: projectId, task: { content: 'CreateTask' } }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:create)
      expect(flash[:success]).to eq "Task created!"
      expect(lastTask.content).to eq 'CreateTask'
    }.to change(Task, :count).by(1)
  end

  it "Edit task" do
    get :edit, xhr: true, params: { project_id: projectId, id: projectTask.id }
    expect(response).to have_http_status(:success)
    expect(response).to render_template(:edit)
  end

  it "Update task" do
    patch :update, xhr: true, params: { project_id: projectId, id: projectTask.id, task: { content: 'newTask' } }
    expect(response).to have_http_status(:success)
    expect(response).to render_template(:update)
    expect(flash[:success]).to eq "Task updated!"
    expect(lastTask.content).to eq "newTask"
  end

  it "Complete task" do
    expect(projectTask.complete).to eq false
    get :complete, xhr: true, params: { project_id: projectId, id: projectTask.id, task: { complete: true } }
    expect(response).to have_http_status(:success)
    expect(response).to render_template(:complete)
    expect(flash[:info]).to eq "Task completed!"
    expect(lastTask.complete).to eq true
  end

  it "Delete task" do
    delete :destroy, xhr: true, params: { project_id: projectId, id: projectTask.id }
    expect(response).to have_http_status(:success)
    expect(response).to render_template(:destroy)
    expect(flash[:danger]).to eq "Task deleted!" 
    expect(lastTask).to be nil
  end

  it "sortUp task" do
    patch :sort_up, xhr: true, params: { project_id: projectId, id: projectTask.id }
    expect(response).to have_http_status(:success)
    expect(response).to render_template(:sort_up)
  end

  it "sortDown task" do
    patch :sort_down, xhr: true, params: { project_id: projectId, id: projectTask.id }
    expect(response).to have_http_status(:success)
    expect(response).to render_template(:sort_down)
  end

  it "Create with empty task name" do
    expect {
      post :create,xhr: true, params: { project_id: projectId, task: { content: '' } }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:valid)
      expect(flash[:danger]).to eq "Can't be blank!"
    }.to change(Task, :count).by(0)
  end

  it "Update with empty task name" do
    patch :update, xhr: true, params: { project_id: projectId, id: projectTask.id, task: { content: '' } }
    expect(response).to have_http_status(:success)
    expect(response).to render_template(:valid)
    expect(flash[:danger]).to eq "Can't be blank!"
    expect(lastTask.content).to eq (projectTask.content)
  end

  context "Test routes" do
    it { should route(:get, '/projects/2/tasks/new').to(action: :new, project_id: 2) }
    it { should route(:post, '/projects/2/tasks').to(action: :create, project_id: 2) }
    it { should route(:get, '/projects/2/tasks/1/edit').to(action: :edit, id: 1, project_id: 2) }
    it { should route(:patch, '/projects/2/tasks/1').to(action: :update, id: 1, project_id: 2) }
    it { should route(:delete, '/projects/2/tasks/1').to(action: :destroy, id: 1, project_id: 2) }
    it { should route(:get, '/projects/2/tasks/1/complete').to(action: :complete, id: 1, project_id: 2) }
    it { should route(:patch, '/projects/2/tasks/1/sortUp').to(action: :sort_up, id: 1, project_id: 2) }
    it { should route(:patch, '/projects/2/tasks/1/sortDown').to(action: :sort_down, id: 1, project_id: 2) }
  end
end