class UserMailer < ActionMailer::Base
  default from: "bookshop024@gmail.com"
  def send_comment(user, id, us_email, content, time_comment, book_owner, book_author)
    @user = user
    @us_email = us_email
    @url  = "http://localhost:3000/books/"
    @url += id.to_s
    @content = content
    @time_comment = time_comment
    @book_owner = book_owner
    @book_author = book_author
    
    mail(:to => user.email, :subject => "New comment to your book")
  end
end
