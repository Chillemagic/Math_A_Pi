class ChatsController < ApplicationController
  # Auth Devise user before showing Chat
  before_action :authenticate_user!
  before_action :set_chat, only: %i[show edit update destroy]
  before_action :authorize_chat, only: %i[show edit update destroy]

  def index
    @chats = Chat.order(created_at: :desc)
  end

  def new
    @chat = Chat.new
    @selected_model = params[:model]
  end

  def create
    return unless prompt.present?

    @chat = Chat.create!(model: model)
    ChatResponseJob.perform_later(@chat.id, prompt)

    redirect_to @chat, notice: 'Chat was successfully created.'
  end

  def show
    @message = @chat.messages.build
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def authorize_chat
    unless @chat.user_id == current_user.id
      redirect_to chats_path, alert: "You don't have permission to access this chat."
    end
  end

  def model
    params[:chat][:model].presence
  end

  def prompt
    params[:chat][:prompt]
  end
end
