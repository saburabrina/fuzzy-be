require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  user = {username: "user", email: 'email@email', password: 'password', password_confirmation: 'password'}
  
  describe "POST /create" do
    before do
      request.headers["Accept"] = "application/json"
    end
    
    it "has a 200 status code and create user and new session" do
      post :create, params: {user: user}
      _user = User.find_by(username: user[:username])

      expect(response.status).to eq(200)
      expect(_user).not_to be_nil
      expect(session[:user_id]).to eq(_user.id)
    end
  end
end
