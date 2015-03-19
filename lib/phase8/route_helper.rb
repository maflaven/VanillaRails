require 'active_support/inflector'

module RouteHelper
  def link_to(name_string, path_parameters, method = :get)
    "<a href='#{parsed_path(path_parameters, method)}'>#{name_string}</a>"
  end

  def button_to(name_string, path_parameters, method = :get)
    html = ""
    html += "<form action='#{parsed_path(path_parameters, method)}' "
    html += "method='#{(method == :post) | (method == :delete) ? "post" : "get"}'>"
    html += "\n<input type='submit' value='#{name_string}'>"

    html
  end

  def parsed_path(path_parameters, method)
    prefixes = /^(.+)\_.+$/.match(path_parameters)[1].split("_")
    postfixes = /^.+\((.+)\)$/.match(path_parameters)
    postfixes = postfixes[1].split(", ") unless postfixes.nil?
    p postfixes
    parsed_path = ""

    return parsed_path += "/#{prefixes.first.pluralize}/" if postfixes.nil?

    prefixes.each_with_index do |prefix, i|
      parsed_path += "#{prefix.pluralize}/"
      parsed_path += "#{postfixes[i]}/" unless postfixes[i].nil?
    end

    if (method == :edit) | (method == :new)
      parsed_path += "#{method.to_s}"
    end

    parsed_path
  end
end
