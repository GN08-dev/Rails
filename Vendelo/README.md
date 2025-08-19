# README

se quito esta parte de la vista de index.html.erb para simplificar con un partial
<%# recorrer un bucle para visualizar la informacion de los productos %>
<%# aqui no imprime nada %>
<% @products.each do |producto| %>
<%# se le paso el class para agregar una clase y aparte porque se ocupa para el test de del asssert_select %>
<%= link_to product_path(producto.id) ,class: "product" do %>
<%# el = dentro de el codigo de ruby sirve para imprimir el mensaje en consola y si no lo tiene no imprime nada %>
<h2> <%= producto.title %> </h2>
<%= image_tag producto.photo, width: 200 if producto.photo.attached? %>
<p>$<%= producto.price%></p>
<%end%>
<% end %>
