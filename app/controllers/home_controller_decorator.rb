Spree::HomeController.class_eval do
  skip_before_filter :verify_authenticity_token, :only => [:add_to_cart]
  def add_to_cart
    if params[:items]

      order = current_order(create_order_if_necessary: true)

      puts '----------------'
      puts order.inspect
      puts '----------------'

      items = eval(params[:items])

      (0..items.length - 1).step(2).each do |index|
        # if !order.line_items.find_by_variant_id(items[index]) && items[index+1] > 0
        #   order.contents.add(Spree::Variant.find(items[index]), items[index+1], {})
        # elsif (order.line_items.find_by_variant_id(items[index]) &&
        #   order.line_items.find_by_variant_id(items[index]).quantity != items[index+1] && items[index+1] > 0)
        #     order.contents.add(Spree::Variant.find(items[index]), items[index+1], {})
        # end
        if items[index+1] > 0
          order.contents.add(Spree::Variant.find(items[index]), items[index+1], {})
        end
      end

    end

    redirect_to :back
  end
end
