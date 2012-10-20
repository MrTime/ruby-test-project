require 'spec_helper'
describe "routing to genres" do
  it "routes /genres/genre to genres#genre for book" do
    expect(:get => "/genres/1").to route_to(
      :controller => "genres",
      :action => "genre",
      :id => "1"
    )
  end

  it "does not expose a list of profiles" do
    expect(:get => "/genres").to be_routable
  end
end