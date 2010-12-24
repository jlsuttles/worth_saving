require "spec_helper"

describe DraftsController do
  describe "routing" do

    it "recognizes and generates #create" do
      { :post => "/drafts" }.should route_to(:controller => "drafts", :action => "create")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/drafts/1" }.should route_to(:controller => "drafts", :action => "destroy", :id => "1")
    end

  end
end
