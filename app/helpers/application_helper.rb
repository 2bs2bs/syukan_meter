module ApplicationHelper

  def flash_message_classes(message_type)
    case message_type
    when 'success'
      'bg-green-500 text-black'
    when 'alert'
      'bg-red-500 text-black'
    else
      'bg-blue-500 text-black'
    end
  end
end
