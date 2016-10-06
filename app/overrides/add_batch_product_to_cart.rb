Deface::Override.new(:virtual_path => 'spree/home/index',
  :name => 'replace_side_bar',
  :remove => '[data-hook="homepage_sidebar_navigation"]')

Deface::Override.new(:virtual_path => 'spree/shared/_products',
  :name => 'insert_hello',
  :insert_top => '[data-hook="products_list_item"]',
  :text => '<% if product.can_supply? %>
          <div class="add-to-cart">
            <div class="input-group" style="width: 100%">
              <%= render :partial => "spree/home/input_widget", :locals => { :product => product } %>
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
                $(".btn-number").click(function(e){
                    e.preventDefault();

                    fieldName = $(this).attr("data-field");
                    type      = $(this).attr("data-type");
                    var input = $("input[name=\'"+fieldName+"\']");
                    var currentVal = parseInt(input.val());
                    if (!isNaN(currentVal)) {
                        if(type == "minus") {

                            if(currentVal > input.attr("min")) {
                                input.val(currentVal - 1).change();
                            }
                            if(parseInt(input.val()) == input.attr("min")) {
                                $(this).attr("disabled", true);
                            }

                        } else if(type == "plus") {

                            if(currentVal < input.attr("max")) {
                                input.val(currentVal + 1).change();
                            }
                            if(parseInt(input.val()) == input.attr("max")) {
                                $(this).attr("disabled", true);
                            }

                        }
                    } else {
                        input.val(0);
                    }
                });
                $(".input-number").focusin(function(){
                   $(this).data("oldValue", $(this).val());
                });
                $(".input-number").change(function() {

                  minValue =  parseInt($(this).attr("min"));
                  maxValue =  parseInt($(this).attr("max"));
                  valueCurrent = parseInt($(this).val());

                  name = $(this).attr("name");
                  if(valueCurrent >= minValue) {
                      $(".btn-number[data-type=\'minus\'][data-field=\'"+name+"\']").removeAttr("disabled")
                  } else {
                      alert("Sorry, the minimum value was reached");
                      $(this).val($(this).data("oldValue"));
                  }
                  if(valueCurrent <= maxValue) {
                      $(".btn-number[data-type=\'plus\'][data-field=\'"+name+"\']").removeAttr("disabled")
                  } else {
                      alert("Sorry, the maximum value was reached");
                      $(this).val($(this).data("oldValue"));
                  }


                });
                $(".input-number").keydown(function (e) {
                    // Allow: backspace, delete, tab, escape, enter and .
                    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 190]) !== -1 ||
                         // Allow: Ctrl+A
                        (e.keyCode == 65 && e.ctrlKey === true) ||
                         // Allow: home, end, left, right
                        (e.keyCode >= 35 && e.keyCode <= 39)) {
                             // let it happen, don"t do anything
                             return;
                    }
                    // Ensure that it is a number and stop the keypress
                    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                        e.preventDefault();
                    }
                });


                $(".add_to_cart").click(function() {
                  var items = $(".product-number").map(function() {
                    return [$(this).attr("variant_id"), $(this).val()];
                  }).toArray();

                  post("/home/add_to_cart", {items: "["+items+"]"}, "post");
                });
              });
            </script>'
  )
