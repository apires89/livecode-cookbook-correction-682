require 'csv'
require_relative "recipe"
class Cookbook
  def initialize(csv_filepath)
    @csv_filepath = csv_filepath
    @recipes = []
    load_csv if File.exists?(csv_filepath)
  end

  def all
    @recipes
  end

  def add(recipe)
    @recipes << recipe
    save_csv
  end

  def mark_recipe_as_done(index)
    recipe = @recipes[index]
    recipe.mark_as_done!
    save_csv
  end


  def delete(index)
    @recipes.delete_at(index)
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_filepath, headers: :first_row, header_converters: :symbol) do |row|
      #convert the strings into an instance of Recipe
      row[:done] = row[:done] == "true"
      recipe = Recipe.new(row)
      #add/push them to the @recipes array
      @recipes << recipe
    end
  end

  def save_csv
    CSV.open(@csv_filepath,"wb") do |csv|
      #iterate over the @recipes array
      csv << ['name','description','prep_time','done']
      @recipes.each do |recipe|
        #push each of the strings of the instances into the csv
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.done]
      end
    end
  end


end
