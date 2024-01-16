module HabitsHelper
  def habit_display(habit, date)
    if date.today?
      progress = habit.progresses.detect { |p| p.date == date }
      display_for_today(habit, progress)
    elsif date.past?
      progress = habit.progresses.detect { |p| p.date == date }
      display_for_past(habit, progress)
    else
      habit.name
    end
  end

  def display_for_today(habit, progress)
    if progress.present?
      link_to habit.name, progress_path(progress), data: { turbo_method: :delete }
    else
      link_to habit.name, progresses_path(habit_id: habit.id), data: { turbo_method: :post }
    end
  end

  def display_for_past(habit, progress)
    if progress&.completed?
      "[完]#{habit.name}"
    else
      "[未]#{habit.name}"
    end
  end
end