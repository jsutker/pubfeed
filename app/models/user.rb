class User < ActiveRecord::Base
  has_many :user_keywords
  has_many :keywords, through: :user_keywords
  has_many :keyword_articles, through: :keywords
  has_many :articles, through: :keyword_articles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
