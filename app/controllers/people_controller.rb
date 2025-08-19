class PeopleController < ApplicationController
  def new
    # @people = current_user.People.new
  end

  def create
    # @people = current_user.people.new(person_params)
    if save
      redirect_to something_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def person_params
    params.require(:person).permit(:name, :fun_facts)
  end
end



# <h1>New Person</h1>

# <%= simple_form_for @person do |f| %>
#   <%= f.input :name %>
#   <%= f.input :fun_facts, as: :text %>
#   <%= f.button :submit, "Create Person" %>
# <% end %>
