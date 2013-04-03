module ResourcesHelper
  
  # Create column heading for a bidirectional sortable column
  # on a paginated table
  def sortable(column, title)
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column) && (sort_direction == "asc") ?
        "desc" : "asc"
    link_to(title, request.GET.merge({:page => 1,
        :sort => column, :direction => direction}), {:class => css_class})
  end

end
