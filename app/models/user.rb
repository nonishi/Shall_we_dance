class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one :post, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
  
  has_many :room_users
  has_many :chats
end
