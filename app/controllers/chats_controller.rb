class ChatsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_person


  def new
    @chat = @person.chats.new
  end

  def create
    @chat = @person.chats.new(chat_params)
    @chat.user = current_user

    if @chat.save
      redirect_to person_path(@person)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @chat = @person.chats.find(params[:id])
    @chat.destroy
    redirect_to person_path(@person)
  end


  private

  def chat_params
    params.require(:chat).permit(:name)
  end

  def set_person
    @person = current_user.people.find(params[:person_id])
  end
end

# button for delete

# <%= button_to "Delete", person_chat_path(@person, @chat),
#           method: :delete,
#           data: { confirm: "Are you sure you want to delete this chat?" } %>



# this is the form for new chat

#  <h1>New Chat</h1>

# <%= simple_form_for @chat do |f| %>
#   <%= f.input :name %>
#   <%= f.button :submit, "Create Chat" %>
#  <% end %>
