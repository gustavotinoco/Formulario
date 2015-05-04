class TodosController < ApplicationController
  def index
  	@todo_items=Todo.all
  	@new_todo= Todo.new
  end

  def add
  	todo = Todo.create(:todo_item => params[:todo][:todo_item])
  	todo.save
  	if !todo.valid?
  		flash[:error] = "No puede dejar el campo de Todo item en blanco"
  	else
  		flash[:success] = "Se añadio a la lista exitosamente"
	  end
    redirect_to index_path
  end

  def complete
    if params[:todos_checkbox] != nil
      

      params[:todos_checkbox].each do |check|
        todo_id = check
        t = Todo.find_by_id(todo_id)
        t.update_attribute(:completed, !t.completed)
      #code to update the status here
      end
    else
      flash[:error] = "Seleccione almenos una opcion"
    end
	  redirect_to index_path
  end

  def delete
    if params[:todos_checkbox] != nil

      ids = params[:todos_checkbox].collect {|id| id.to_i} 
      Todo.where(:id =>ids).destroy_all
      flash[:success] = "Se eliminarion las tareas exitosamente"
    else
      flash[:error] = "Seleccione almenos una opcion"
    end
  end


  def edit
    @todo_item = todo_item.find(params[:todo_id])

    redirect_to index_path
  end
end


#todo.errors.full_messages.join("<br>").html_safe