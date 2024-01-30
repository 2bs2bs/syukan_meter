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
    # progressの状態に応じたアイコンと色のクラスを設定
    if progress&.completed?
      icon_class = "text-green-500 dark:text-green"
      icon_path = "M2 12a10 10 0 1 1 20 0 10 10 0 0 1-20 0Zm13.7-1.3a1 1 0 0 0-1.4-1.4L11 12.6l-1.8-1.8a1 1 0 0 0-1.4 1.4l2.5 2.5c.4.4 1 .4 1.4 0l4-4Z"
      fill_type = "currentColor"
    else
      icon_class = "text-red-500 dark:text-red"
      icon_path = "m15 9-6 6m0-6 6 6m6-3a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
      fill_type = "none"
    end

    content_tag(:div, class: 'flex items-center') do
      concat(content_tag(:svg, class: "w-6 h-6 #{icon_class}", aria_hidden: true, xmlns: "http://www.w3.org/2000/svg", fill: fill_type, viewBox: "0 0 24 24") do
        concat(content_tag(:path, nil, fill_rule: "evenodd", d: icon_path, clip_rule: "evenodd", stroke: "currentColor", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"))
      end)
      concat(content_tag(:span, habit.name, class: 'ml-2'))
    end
  end
end
