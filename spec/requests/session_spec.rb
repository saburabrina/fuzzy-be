require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  user = {email: 'email@email', password: 'password'}

  before do
    @user = User.create(user)
    request.headers["Accept"] = "application/json"
  end
  
  describe "POST /login" do
    it "has a 200 status code and create a new session" do
      post :create, params: user

      expect(response.status).to eq(200)
      expect(session[:user_id]).to eq(@user.id)
    end
  end

  describe "DELETE /logout" do
    it "has a 200 status code and destroy session" do
      post :destroy
      
      expect(response.status).to eq(200)
      expect(session[:user_id]).to be_nil
    end
  end
end
