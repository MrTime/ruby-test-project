require "spec_helper"

describe GenresController do 
  describe "genre" do
    it "renders the genre template" do
      get :genre
      response.should render_template("genre")
      response.body.should == ""
    end
    it "renders the genres/genre template" do
      get :genre
      response.should render_template("genres/genre")
      response.body.should == ""
    end
  end
end