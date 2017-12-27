require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  login_user

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  let(:valid_attributes) {
    { caption: 'food', user_id: subject.current_user.id, image: Faker::LoremPixel.image('500x500', false, 'food') }
  }

  let(:invalid_attributes) {
    { caption: 'food', image: Faker::LoremPixel.image('500x500', false, 'food') }
  }

  let(:valid_session) { subject.current_user }

  describe "GET #index" do
    it "returns a success response" do
      post = Post.create! valid_attributes
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Post" do
        expect {
          post :create, params: {post: valid_attributes}, format: :js
        }.to change(Post, :count).by(1)
      end
    end

    context "with invalid params" do
      it "returns a unsuccess response" do
        expect{ post :create, params: {post: invalid_attributes} }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "GET #users" do
    it "returns users" do
      user = User.create!(email: 'admin@example.com', password: '123123')
      get :users, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #user_posts" do
    it "returns subscribed posts" do
      get :user_posts, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #follow" do
    it "returns follow success" do
      get :follow, params: { id: User.last, type: 'follow', page: 'index'}
      expect(response).to be_success
    end

    it "returns unfollow success" do
      get :follow, params: { id: User.last, type: 'unfollow', page: 'user'}
      expect(response).to be_success
    end
  end

end
