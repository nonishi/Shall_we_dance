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
    "バランス良く両方": 5,
  }, _prefix: true
  enum experience: {
    "問わない": 0,
    "半年以上": 1,
    "1年以上": 2,
    "3年以上": 3,
    "5年以上": 4,
    "10年以上": 5,
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

  scope :search, -> (search_params) do
    return if search_params.blank?

    target(search_params[:target]).
      status(search_params[:status]).
      height_from(search_params[:height_from]).
      height_to(search_params[:height_to]).
      age_from(search_params[:age_from]).
      age_to(search_params[:age_to]).
      area(search_params[:area])
  end

  scope :target, -> (target) { where(users: { target: target }) if target.present? }
  scope :status, -> (status) { where(users: { status: status.to_sym }) if status.present? }
  scope :height_from, -> (from) { Post.joins(:user).where('height >= ?', from) if from.present? }
  scope :height_to, -> (to) { Post.joins(:user).where('height <= ?', to) if to.present? }
  scope :age_from, -> (from) { Post.joins(:user).where('age >= ?', from) if from.present? }
  scope :age_to, -> (to) { Post.joins(:user).where('age <= ?', to) if to.present? }
  scope :area, -> (area) { where(users: { area: area.to_sym }) if area.present? }
end
