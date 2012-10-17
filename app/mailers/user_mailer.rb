class UserMailer < ActionMailer::Base
  default from: "bookshop024@gmail.com"
  def send_comment(user, comment, email, id)
    @comment = comment
    @email = email	 
    @user = user
    @url  = "http://localhost:3000/books/"
    @url += id.to_s
    mail(:to => user.email, :subject => "New comment to your book")
  end
end
