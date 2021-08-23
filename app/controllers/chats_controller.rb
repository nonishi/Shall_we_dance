class ChatsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    rooms = current_user.room_users.pluck(:room_id)
    room_users = RoomUser.find_by(user_id: @user.id, room_id: rooms)

    if room_users.nil?
      @room = Room.new
      @room.save
      RoomUser.create(user_id: current_user.id, room_id: @room.id)
      RoomUser.create(user_id: @user.id, room_id: @room.id)
    else
      @room = room_users.room
    end

    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    visited_user = RoomUser.where(room_id: @chat.room_id).where.not(user_id: current_user.id).first
    notification = current_user.active_notifications.new(
      room_id: @chat.room_id,
      chat_id: @chat.id,
      visited_id: visited_user.user_id,
      visitor_id: current_user.id,
      action: 'dm'
    )
    notification.save if notification.valid?
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
