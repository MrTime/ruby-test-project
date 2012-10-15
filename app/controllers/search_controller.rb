class SearchController < ApplicationController

  def search_books
    search_input = "#{params[:search_title]}"
    search_input = search_input.match(/[^?*]*/).to_s

    if search_input == ""
      "Book whith title or author or description or price '#{params[:search_title]}' not found  !!!"
    else
      search = search_input.gsub!(/'[^']*'/).to_a
      search.collect{|n| n.gsub!("'", "") }
      search << search_input.split(" ")
      search.flatten!
      search = search.join("|")
    end



    @book=Book.where('title RLIKE ? or author RLIKE ? or description RLIKE ? or price RLIKE ?', search, search, search, search).all

  end
end
