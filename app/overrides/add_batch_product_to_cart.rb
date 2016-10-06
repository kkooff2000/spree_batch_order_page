Deface::Override.new(:virtual_path => 'spree/home/index',
  :name => 'replace_side_bar',
  :remove => '[data-hook="homepage_sidebar_navigation"]')

Deface::Override.new(:virtual_path => 'spree/shared/_products',
  :name => 'insert_hello',
  :insert_top => '[data-hook="products_list_item"]',
  :text => '<% if product.can_supply? %>
          <div class="add-to-cart">
            <div class="input-group" style="width: 100%">
              <% if current_order && current_order.line_items.find_by_variant_id(product.id) %>
                <%= number_field_tag :quantity, current_order.line_items.find_by_variant_id(product.id).quantity, class: "title form-control product-number", min: 0, :variant_id => product.id%>
              <% else %>
                <%= number_field_tag :quantity, 0, class: "title form-control product-number", min: 0, :variant_id => product.id%>
              <% end %>
            </div>
          </div>
        <% end %>'
  )

Deface::Override.new(:virtual_path => 'spree/home/index',
  :name => 'add_button',
  :insert_top => '[data-hook="homepage_products"]',
  :text => '<button class="btn btn-success pull-right add_to_cart">Add to cart</button>
            <br>
            <br>
            <script>
              function post(path, params, method) {
                method = method || "post";
                var form = document.createElement("form");
                form.setAttribute("method", method);
                form.setAttribute("action", path);

                for(var key in params) {
                  if(params.hasOwnProperty(key)) {
                    var hiddenField = document.createElement("input");
                    hiddenField.setAttribute("type", "hidden");
                    hiddenField.setAttribute("name", key);
                    hiddenField.setAttribute("value", params[key]);

                    form.appendChild(hiddenField);
                   }
                }

                document.body.appendChild(form);
                form.submit();
              }

              $(document).ready(function(){
                $(".add_to_cart").click(function() {
                  var items = $(".product-number").map(function() {
                    return [$(this).attr("variant_id"), $(this).val()];
                  }).toArray();

                  post("/home/add_to_cart", {items: "["+items+"]"}, "post");
                });
              });
            </script>'
  )
