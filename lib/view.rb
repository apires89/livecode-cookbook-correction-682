class View
  def display(recipes)
    #iterates to the array of recipes with index
    recipes.each_with_index do |recipe, index|
      #puts each of the recipes in order
      done = recipe.done ? "[X]" : "[ ]"
      puts "#{index + 1} - #{done} - #{recipe.name} - #{recipe.description} - #{recipe.prep_time}"
    end
  end

  def ask_input(input)
    puts "What the #{input}"
    gets.chomp
  end

  def get_index
    puts "Index?"
    gets.chomp.to_i - 1
  end

end
