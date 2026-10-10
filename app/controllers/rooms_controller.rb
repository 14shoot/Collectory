class RoomsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @rooms = current_user.rooms.includes(:users, :messages)
                           .order(updated_at: :desc)
    end
  
    def create
      user = User.find(params[:user_id])
  
      room = current_user.rooms
                         .where(id: user.rooms.select(:id))
                         .first
  
      unless room
        room = Room.create!
  
        Entry.create!(user: current_user, room: room)
        Entry.create!(user: user, room: room)
      end
  
      redirect_to room_path(room)
    end
  
    def show
      @room = Room.find(params[:id])
      @messages = @room.messages.order(created_at: :asc)
      @message = Message.new
    end
  end