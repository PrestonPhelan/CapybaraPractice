require 'rails_helper'
require 'application_controller'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders sign up page" do
      get :new, user: {}
      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "redirects to somewhere" do
        post :create, user:{ username: "matt", password: "123456" }
        expect(response).to redirect_to(goals_url)
      end
    end

    context "with invalid params" do
      it "checks for valid username" do
        post :create, user: { password: "236323" }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

      it "checks for valid password" do
        post :create, user: { username: "matt", password: 2465 }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end
  end


end
