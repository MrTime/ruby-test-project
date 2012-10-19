require "spec_helper.rb"

describe "genres/genre.html.haml" do
  before(:each) do
    @book = assign(:book, stub_model(Book))
  end

  it "renders the genre.html.haml" do
    stub_template "genres/genre.html.haml" => "This content"
    render
    rendered.should =~ /This content/
  end
  
    context "with 2 genres" do
    before(:each) do
      assign(:books, [
        stub_model(Book, :genre => "slicer"),
        stub_model(Book, :genre => "dicer")
      ])
    end
  end
end