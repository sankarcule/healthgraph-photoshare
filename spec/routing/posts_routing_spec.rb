require "rails_helper"

RSpec.describe PostsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/posts").to route_to("posts#index")
    end

    it "routes to #create" do
      expect(:post => "/posts").to route_to("posts#create")
    end

    it "routes to #follow" do
      expect(:get => "/posts/follow").to route_to("posts#follow")
    end

    it "routes to #users" do
      expect(:get => "/posts/users").to route_to("posts#users")
    end

    it "routes to #user_posts" do
      expect(:get => "/posts/user_posts").to route_to("posts#user_posts")
    end

  end
end
