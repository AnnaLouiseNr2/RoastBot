class ChatsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_person, except: [:destroy]

  def show
    @chat = Chat.find(params[:id])
    @message = @chat.messages.new
  end

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
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to person_path(@chat.person), status: :see_other
  end


  private

  def chat_params
    params.require(:chat).permit(:name, :tone, :format)
  end

  def set_person
    @person = current_user.people.find(params[:person_id])
  end
end

# button for delete




# this is the form for new chat
