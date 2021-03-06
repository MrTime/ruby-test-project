class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :fullname, :shortbio, :weburl
  # attr_accessible :title, :body
  has_many :books
  has_many :comments
  has_many :rate
  has_one  :photo
  has_many :services, :dependent => :destroy
  has_many :articles, :dependent => :destroy
  has_many :ratings, :dependent => :destroy 
  belongs_to :country
  
end
