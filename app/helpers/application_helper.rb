module ApplicationHelper

  def flash_class(level)
    case level
    when :notice then "alert-box"
    when :success then "alert-box success"
    when :alert then "alert-box alert round"
    end
  end

end
