class User < ActiveRecord::Base

  #Validates that the password comes in an alphanumeric format.
  validates_format_of  :password, with: /\A([a-zA-Z]|\d)*\z/
  
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
