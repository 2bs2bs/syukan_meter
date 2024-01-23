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
    icon = progress&.completed? ? 'check-circle' : 'x-circle'

    content_tag(:div, class: 'flex items-center') do
      concat(content_tag(:svg, class: "w-6 h-6 text-gray-800 dark:text-gray", aria_hidden: true, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24") do
        concat(content_tag(:path, nil, stroke: "currentColor", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: icon_path(icon)))
      end)
      concat(content_tag(:span, habit.name, class: 'ml-2'))
    end
  end

  private

  def icon_path(icon_name)
    case icon_name
    when 'check-circle'
      "M8.5 11.5 11 14l4-4m6 2a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
    when 'x-circle'
      "m15 9-6 6m0-6 6 6m6-3a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
    end
  end
end