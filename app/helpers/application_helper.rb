module ApplicationHelper

  def sort_column(column, text, options = {})
    current_column = params[:sort_column]
    current_order  = params[:sort_order]
    params         = request.query_parameters.symbolize_keys.merge(sort_column: column, sort_order: 'asc')

    params[:sort_order] = current_order == 'desc' ? 'asc' : 'desc'

    if current_column.present? && current_column.to_sym == column
      caret = current_order == 'desc' ? 'caret-down' : 'caret-up'
      caret_icon = fa_icon caret
    end

    link_to dji_track_orders_path(params), class: 'sort-link' do
      "#{text} #{caret_icon}".html_safe
    end
  end

end
