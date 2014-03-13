module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Turnos"      
    end
  end
end
