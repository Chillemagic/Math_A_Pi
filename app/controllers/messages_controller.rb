class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat
  before_action :authorize_chat

  def create
    return unless content.present?

    ChatResponseJob.perform_later(@chat.id, content)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @chat }
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def authorize_chat
    return if @chat.user_id == current_user.id

    redirect_to chats_path, alert: "You don't have permission to access this chat."
  end

  def content
    params[:message][:content]
  end
end
