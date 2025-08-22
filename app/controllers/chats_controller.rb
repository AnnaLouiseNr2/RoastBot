# frozen_string_literal: true
class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_person, only: %i[index new create show destroy]

  def index
    @chats = current_user.chats.order(updated_at: :desc)
  end

  def show
    @chat = current_user.chats.find(params[:id])
    @message = @chat.messages.new
  end

  def new
    @chat = (@person ? @person.chats.build : Chat.new)
    @chat.name ||= 'Untitled'
  end

  def create
    @chat = (@person ? @person.chats.build(chat_params) : Chat.new(chat_params))
    @chat.user ||= current_user


    if @chat.save
      redirect_to person_chat_path(@person, @chat)
      @message = @chat.messages.build(content: "Roast this person!", role: "user")
      @message.initialize_llm

    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy
    redirect_to person_path(@chat.person), notice: "Chat deleted", status: :see_other
  end

  private

  def set_person
    return unless params[:person_id]
    @person = current_user.people.find_by(id: params[:person_id])
  end

  def chat_params
    params.fetch(:chat, {}).permit(:name, :tone, :format, :challenge_id)
  end
end
