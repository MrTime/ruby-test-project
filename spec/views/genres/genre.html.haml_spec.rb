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
      
    it "value in the page" do
      stub_template "genres/genre.html.haml" => "Genres"
      render
      expect(rendered).to match /Genres/
    end
end