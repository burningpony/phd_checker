class ExperimentOption
  def self.all
    [{name: 'essays', id: 1},
     {name: 'math_quizzes', id: 2},
     {name: 'combination', id: 3}]
  end

  def self.find_all(ids)
    return nil unless ids
    all.find_all {|option| ids.include?(option[:id])}
  end
end
