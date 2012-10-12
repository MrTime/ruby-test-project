class SearchController < ApplicationController

  def search_books
    search_input = "%#{params[:search_title]}%"

    search = search_input.gsub!(/'[^']*'/).to_a
    search.collect{|n| n.gsub!("'", "") }
    search << search_input.split(" ")
    search.flatten!
    search = search.join("|")

    @book=Book.where('title LIKE ? or author LIKE ? or description LIKE ? or price LIKE ? or title RLIKE ? or author RLIKE ? or description RLIKE ? or price RLIKE ?', search, search, search, search, search, search, search, search  ).all

  end
end
