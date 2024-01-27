module ApplicationHelper

  def page_title(page_title = '')
    base_title = 'Syukan meter'

    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def flash_message_classes(message_type)
    case message_type
    when 'success'
      'text-green-800 bg-green-50 dark:text-green-400'
    when 'danger'
      'text-red-800  bg-red-50 dark:text-red-400'
    else
      'text-blue-800 bg-blue-50 dark:text-blue-400'
    end
  end
end
