module ApplicationHelper
  def sortable(column, title = column)
  title ||= column.titleize
  direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
  link_to title, :sort => column, :direction => direction
 end
end
