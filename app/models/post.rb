class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

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
  
  def create_notification_favorite(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    if temp.blank?
      notification = current_user.active_notifications.new(post_id: id, visited_id: user_id, action: 'favorite')
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
end
