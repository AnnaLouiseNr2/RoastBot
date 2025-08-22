class PeopleController < ApplicationController

  before_action :authenticate_user!

  def index

    @people = current_user.people.order(created_at: :desc)
    @person = Person.new
  end


  def create
    @person = current_user.people.new(person_params)
    if @person.save
      redirect_to person_path(@person)
    else
      @people = current_user.people.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def person_params
    params.require(:person).permit(:name, :fun_facts, :image)
  end

  def show

  @person = current_user.people.find_by(id: params[:id])
  if @person.nil?
    redirect_to people_path, alert: "Not authorized to view this page"
  else
    @chats = @person.chats.where(user: current_user).order(created_at: :desc)
  end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    redirect_to people_path, status: :see_other
  end

end
