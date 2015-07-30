class EmailAutomator
  
  def self.clean
    Article.destroy_all
    Keyword.all.each do |keyword|
      if keyword.users.empty?
        keyword.destroy
      end
    end
  end

  def self.retrieve
    Keyword.all.each do |keyword|
      keyword.get_all_recent_abstracts
    end
  end

  def self.send
    User.all.each do |user|
      UserMailer.daily_result_email(user).deliver_now
    end
  end

  def self.clean_and_send
    self.clean
    self.retrieve
    self.send
  end
  
end