class Recipe
  attr_reader :name, :description, :prep_time, :done

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
    @done = attributes[:done] || false
  end

  def mark_as_done!
    @done = true
  end

end

#Recipe.new(name: "cake", description: "chocolate", prep_time: "15mins")
