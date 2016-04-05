module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end
 # Add to config/initializers/form.rb or the end of app/helpers/application_helper.rb
 module ActionView
   module Helpers
     class FormBuilder
       def date_select(method, options = {}, html_options = {})
         existing_date = @object.send(method)

         # Set default date if object's attr is nil
         existing_date ||= Time.now.to_date

         formatted_date = existing_date.to_date.strftime("%F") if existing_date.present?
         @template.content_tag(:div, :class => "input-group") do
           text_field(method, :value => formatted_date, :class => "form-control datepicker", :"data-date-format" => "MM-DD-YYYY") +
           @template.content_tag(:span, @template.content_tag(:span, "", :class => "glyphicon glyphicon-calendar") ,:class => "input-group-addon")
         end
       end

       def datetime_select(method, options = {}, html_options = {})
         existing_time = @object.send(method)

         # Set default date if object's attr is nil
         existing_date ||= Time.now

         formatted_time = existing_time.to_time.strftime("%F %I:%M %p") if existing_time.present?
         @template.content_tag(:div, :class => "input-group") do
           text_field(method, :value => formatted_time, :class => "form-control datetimepicker", :"data-date-format" => "MM-DD-YYYY hh:mm A") +
           @template.content_tag(:span, @template.content_tag(:span, "", :class => "glyphicon glyphicon-calendar") ,:class => "input-group-addon")
         end
       end
     end
   end
 end




end
