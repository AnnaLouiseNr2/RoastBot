class PeopleController < ApplicationController

  before_action :authenticate_user!


  def new
    @person = current_user.people.new
  end

  def create
    @person = current_user.people.new(person_params)
    if @person.save
      redirect_to people_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def person_params
    params.require(:person).permit(:name, :fun_facts)
  end

  def show
  @person = Person.find(params[:id])
end

end




# paste this into perople index


# #  <h1>New Person</h1>

# <%= simple_form_for @person do |f| %>
#   <%= f.input :name %>
#   <%= f.input :fun_facts, as: :text %>
#   <%= f.button :submit, "Create Person" %>
#  <% end %>
