# frozen_string_literal: true

require 'rails_helper'

describe HomeController, type: :controller do
  it 'blocks unauthenticated access' do
    sign_in nil
    get :index
    expect(response).to redirect_to(new_user_session_path)
  end

  it 'allows authenticated access' do
    sign_in
    get :index
    expect(response).to be_success
  end

  it { should route(:get, '/').to(action: :index) }
end
