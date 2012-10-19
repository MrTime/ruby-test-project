require "spec_helper.rb"
#require 'rspec'

describe "stub_model(Widget) with a hash of stubs" do
  it 'mock_model Book' do
    book = mock_model("Book")  
    book.should be_a(Book)
  end
  
  let(:book) do
    mock_model Book, :title => "bar",
                       :genre => "roman"
  end
   
  it 'genre book valid' do 
    book.genre.should eql "roman"
  end   
end

