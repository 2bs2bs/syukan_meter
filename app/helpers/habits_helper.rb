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
      render 'calendars/unprogress', habit: habit, progress: progress
    else
      render 'calendars/progress', habit: habit, progress: progress
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