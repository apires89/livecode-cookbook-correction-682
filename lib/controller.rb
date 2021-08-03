require_relative "view"
require_relative "scrapeallrecipes_service"
class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  #method to display all of the recipes
  def list
    @view.display(@cookbook.all)
  end

  #method to create a new recipe
  def create
    #1. get the name of the recipe
    name = @view.ask_input("name")
    #2. get the description
    description = @view.ask_input("description")
    prep_time = @view.ask_input("prep_time")
    #3. create an instance of recipe
    recipe = Recipe.new(name: name, description: description, prep_time: prep_time)
    #4. add it to the cookbook
    @cookbook.add(recipe)

    #5. Display our recipes
    list

  end
  #metohd to destroy a recipe
  def destroy
    #1.List the recipes
    list
    #2. Ask user to select one
    selected = @view.get_index
    #3. go to @recipes and delete the recipe selected
    @cookbook.delete(selected)
    #4. List the recipes
    list
  end

  #method to import recipes from the web
  def import
    #1.Ask the user for keyword
    ingredient = @view.ask_input("ingredient")
    #call the service
    #2. open url
    #3. parse html
    #4.For the first five results
    #5. Create a recipe and store it in a results array
    scrape = ScrapeallrecipesService.new(ingredient)
    imported_recipes = scrape.call

    #6. display the results
    @view.display(imported_recipes)
    #7. ask the user which recipe to import
    selected_recipe = imported_recipes[@view.get_index]
    #8. add it to the cookbook
    @cookbook.add(selected_recipe)
    #9. display it
    list
  end

  def mark_as_done
    #1. display the recipes(view)
    list
    #2. ask the user for and index(view)
    index = @view.get_index
    @cookbook.mark_recipe_as_done(index)
    #3. find that recipe(cookbook)
    #4. mark the recipe as done(model)
    #5. save it to csv(cookbook)
    #6. display the recipes(view)
    list

  end



end
