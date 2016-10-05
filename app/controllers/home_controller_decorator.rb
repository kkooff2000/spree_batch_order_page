Spree::HomeController.class_eval do
  def add_to_cart
    puts '---------------------'
    puts params.inspect
    puts '---------------------'
    if params[:items]
      order = current_order(create_order_if_necessary: true)
      params[:items].each do |item|

      end

    end

    respond_to do |format|
      format.json { render :json => {:result => 'success'}.to_json }
    end
  end
end
