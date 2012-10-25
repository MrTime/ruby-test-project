class Book < ActiveRecord::Base
  require "json"
  attr_accessible :author, :description, :price, :title, :authors, :authors_attributes, :user_id, :isbn, :genre, :year, :keyword, :middle_rate
  has_many :authors
  accepts_nested_attributes_for :authors

  has_many :line_items
  has_one :photo
  has_many :comments

  has_one :rate
  belongs_to :user

  def short_link(uri)
    parameters = {:longUrl=>uri, :apiKey=>"R_7303a1fbe163c575972738f3514acd77", :login=>"popovichjurij"}
    response = Curl::Easy.http_get("http://api.bit.ly/v3/shorten?#{parameters.to_query}") do |curl|
      curl.headers['Api-Version'] = '2.2'
      curl.headers['Content-Type'] = 'application/json'
      curl.headers['Accept'] = 'application/json'
    end
    return JSON.parse(response.body_str)["data"]["url"]
  end

  def full_description(uri)
    "Oh. book #{title} is just amazing! it about #{description} #{short_link(uri)}"
  end
end
