class EmailAutomator

  def self.clean_and_send
    Article.destroy_all
    User.all.each do |user|
      user.keywords.each do |keyword|
        keyword.get_all_recent_abstracts(user)
      end
      UserMailer.daily_result_email(user).deliver_now
    end
  end

end