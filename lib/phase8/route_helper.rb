module RouteHelper
  def link_to(name_string, path_parameter, method = :get)
    html = <<-HTML
      <form action="#{h(path_parameter)}" value="#{h(method)}">
        
    HTML
  end

  def button_to
  end
end
