class MessagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_chat


  def new
    @message = @chat.messages.new
  end

  def create
    @message = @chat.messages.new(message_params)
    @message.chat = @chat

    if @message.save
      redirect_to person_chat_path(@person, @chat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private


  def message_params
    params.require(:message).permit(:content)
  end

  def set_chat
    @chat = current_user.chats.find(params[:chat_id])
    @person = current_user.people.find(params[:person_id])
  end

end



# this is the message form

#  <h1>New mes</h1>

# <%= simple_form_for [@person ,@chat, @message] do |f| %>
#   <%= f.input :content %>
#   <%= f.button :submit, "Create Chat" %>
#  <% end %>
