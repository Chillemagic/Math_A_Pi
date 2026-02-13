class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :challenge

  has_many :messages, dependent: :destroy

  acts_as_chat messages_foreign_key: :chat_id
end
