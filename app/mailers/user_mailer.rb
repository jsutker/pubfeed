class UserMailer < ApplicationMailer
  default from: 'pubfeednotification@gmail.com'

  def daily_result_email(user)
    @user = user
    @articles = user.articles.uniq
    if @articles.length>0
      mail(to: @user.email, subject: "You have #{@articles.length} new article#{@articles.length>1 ? 's' : ''}!")
    end
  end

  def email_favorites(user, receiver)
    @user = user
    @articles = user.favorites
    mail(to: receiver, subject: "Favorite articles from #{user.email} at PubFeed")
  end

end
