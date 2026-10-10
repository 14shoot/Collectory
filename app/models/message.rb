class Message < ApplicationRecord
    belongs_to :user
    belongs_to :room, touch :true
  end