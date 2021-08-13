class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  enum status: { "問わない": 0, "アマチュア": 1, "プロ": 2 }, _prefix: true
  enum directionality: { 
    "問わない": 0,
    "モダンのみ": 1,
    "モダン中心で両方": 2,
    "ラテンのみ": 3,
    "ラテン中心で両方": 4,
    "バランス良く両方": 5
  }, _prefix: true
  enum experience: {
    "問わない": 0,
    "半年以上": 1,
    "1年以上": 2,
    "3年以上": 3,
    "5年以上": 4,
    "10年以上": 5
  }, _prefix: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
