require "spec_helper"

describe GenresController do 
  describe "genre" do
    #fixtures :books

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
      let(:book) do
        mock_model Book, :title => "roman",
                        :genre => "roman"
      end
    it "value books" do
      get :genre
      assigns(:books).size.should == 1  
    end
    

    it "assigns all books to @books" do
      book = stub_model(Book)
      Book.stub(:all) { [book] }
      get :genre
      expect(assigns(:books)).to eq([book])
    end
    end
    
end