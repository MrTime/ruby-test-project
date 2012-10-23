module ApplicationHelper

  # Returns the full title on a per-page basis
  def full_title(page_title)
    base_title = 'BookStore Application'
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def  price money
    number_to_currency money, precision: 2, unit: "$", separator: "."
  end

  def tweet_button(book)
    "<iframe scrolling='no' frameborder='0' allowtransparency='true' src='http://platform.twitter.com/widgets/tweet_button.1347008535.html#_=1350480728010&amp;count=	horizontal&amp;id=twitter-widget-0&amp;lang=en&amp;original_referer=http%3A%2F%2Flocalhost%3A4000%2F&amp;size=m&amp;text=#{book.full_description('http://google.com#{url_for(:action => "show", :id => book)}')}&amp;url=http%3A%2F%2Flocalhost%3A3000%2Flink%2F2' class='twitter-share-button twitter-count-	horizontal' style='width: 82px; height: 22px;' title='Twitter Tweet Button' data-twttr-rendered='true'></iframe>".html_safe
    #change url:"http://google.com" to only_path => false
  end
end
