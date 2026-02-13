class Challenge < ApllicationRecord
  has_one :chat, dependent: :destroy
  has_one :user, through: :chatend
end
