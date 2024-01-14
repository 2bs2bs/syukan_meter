module HabitsHelper
  def habit_display(habit, date)
    if date.today?
      link_to habit.name, progresses_path(habit_id: habit.id), data: { turbo_method: :post }
    elsif date.past?
      progress = habit.progresses.find_by(date: date)
      if progress&.completed?
        "#{habit.name} (完了)"
      else
        "#{habit.name} (未完了)"
      end
    else
      habit.name
    end
  end
end
