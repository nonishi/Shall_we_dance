class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :post, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :room_users
  has_many :chats
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  attachment :profile_image

  with_options presence: true do
    validates :name
    validates :status
    validates :age
    validates :height
    validates :experience
    validates :club_status
    validates :area
  end
  validates :target, inclusion: { in: [true, false] }

  enum area: {
    北海道: 1, 青森県: 2, 岩手県: 3, 宮城県: 4, 秋田県: 5, 山形県: 6, 福島県: 7,
    茨城県: 8, 栃木県: 9, 群馬県: 10, 埼玉県: 11, 千葉県: 12, 東京都: 13, 神奈川県: 14,
    新潟県: 15, 富山県: 16, 石川県: 17, 福井県: 18, 山梨県: 19, 長野県: 20,
    岐阜県: 21, 静岡県: 22, 愛知県: 23, 三重県: 24,
    滋賀県: 25, 京都府: 26, 大阪府: 27, 兵庫県: 28, 奈良県: 29, 和歌山県: 30,
    鳥取県: 31, 島根県: 32, 岡山県: 33, 広島県: 34, 山口県: 35,
    徳島県: 36, 香川県: 37, 愛媛県: 38, 高知県: 39,
    福岡県: 40, 佐賀県: 41, 長崎県: 42, 熊本県: 43, 大分県: 44, 宮崎県: 45, 鹿児島県: 46,
    沖縄県: 47,
  }
  enum status: { "アマチュア": 0, "プロ": 1 }
  enum experience: {
    "未経験": 0,
    "1年未満": 1,
    "1~2年": 2,
    "2~3年": 3,
    "3~5年": 4,
    "5~10年": 5,
    "10年以上": 6,
  }
  enum club_status: {
    "在籍していたことはない": 0,
    "一時在籍していたことがある": 1,
    "モダン専攻卒": 2,
    "ラテン専攻卒": 3,
    "現役モダン専攻": 4,
    "現役ラテン専攻": 5,
  }
end
