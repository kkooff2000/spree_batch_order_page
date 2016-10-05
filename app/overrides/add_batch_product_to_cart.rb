Deface::Override.new(:virtual_path => 'spree/home/index',
  :name => 'replace_side_bar',
  :remove => '[data-hook="homepage_sidebar_navigation"]')

Deface::Override.new(:virtual_path => 'spree/shared/_products',
  :name => 'insert_hello',
  :insert_top => '[data-hook="products_list_item"]',
  :text => '<% if product.can_supply? %>
          <div class="add-to-cart">
            <div class="input-group" style="width: 100%">
              <%= number_field_tag :quantity, 0, class: "title form-control product-number", min: 0, :variant_id => product.master.id%>
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
              $(document).ready(function(){
                $(".add_to_cart").click(function() {
                  var items = $(".product-number").map(function() {return [$(this).attr("variant_id"), $(this).val()];}).toArray();
                  console.log(items);
                  $.ajax({
                    method: "POST",
                    url: "home/add_to_cart",
                    dataType: "jsonp",
                    data: {items: items}
                  }).success(function() {
                      console.log("success");
                    }).fail(function(e) {
                      console.log("error");
                      console.log(e);
                    });
                });
              });
            </script>'
  )
