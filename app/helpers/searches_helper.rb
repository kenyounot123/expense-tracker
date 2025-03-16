module SearchesHelper
  def sort_direction_for(column)
    if params[:sort] == column && params[:direction] == "asc"
      "desc"
    else
      "asc"
    end
  end

  def sort_indicator_for(column)
    link_class = "text-positive hover:text-white transition-colors duration-200 ml-1"

    if params[:sort] == column
      if params[:direction] == "asc"
        content_tag(:a,
          content_tag(:svg,
            content_tag(:path, "", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M5 15l7-7 7 7"),
            xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: "h-4 w-4 text-white"
          ),
          class: link_class,
          href: url_for(request.params.merge(sort: column, direction: sort_direction_for(column)))
        )
      else
        content_tag(:a,
          content_tag(:svg,
            content_tag(:path, "", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M19 9l-7 7-7-7"),
            xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: "h-4 w-4 text-white"
        ),
          class: link_class,
          href: url_for(request.params.merge(sort: column, direction: sort_direction_for(column)))
        )
      end
    else
      content_tag(:a,
        content_tag(:svg,
          content_tag(:path, "", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M7 16V4m0 0L3 8m4-4l4 4m6 0v12m0 0l4-4m-4 4l-4-4"),
          xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", class: "h-4 w-4 text-white"
        ),
        class: link_class,
        href: url_for(request.params.merge(sort: column, direction: "asc"))
      )
    end
  end
end
