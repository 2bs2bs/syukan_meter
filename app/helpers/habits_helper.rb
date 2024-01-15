module HabitsHelper
  def habit_display(habit, date)
    if date.today?
      progress = habit.progresses.find_by(habit_id: habit.id)
      if progress.present?
        link_to habit.name, progress_path(progress), data: { turbo_method: :delete }
      else
        link_to habit.name, progresses_path(habit_id: habit.id), data: { turbo_method: :post }
      end
    elsif date.past?
      progress = habit.progresses.find_by(date: date)
      if progress&.completed?
        "[完]#{habit.name}"
      else
        "[未]#{habit.name}"
      end
    else
      habit.name
    end
  end
end
