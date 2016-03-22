require "rails_helper"

RSpec.describe PersonalitiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/personalities").to route_to("personalities#index")
    end

    it "routes to #new" do
      expect(:get => "/personalities/new").to route_to("personalities#new")
    end

    it "routes to #show" do
      expect(:get => "/personalities/1").to route_to("personalities#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/personalities/1/edit").to route_to("personalities#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/personalities").to route_to("personalities#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/personalities/1").to route_to("personalities#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/personalities/1").to route_to("personalities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/personalities/1").to route_to("personalities#destroy", :id => "1")
    end

  end
end
