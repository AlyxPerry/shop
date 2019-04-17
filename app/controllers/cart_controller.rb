class CartController < ApplicationController
  
	before_action :authenticate_user!, except:[:add_to_cart,:view_cart]

  def add_to_cart
  	@order = current_order

    line_item  = @order.line_items.new(quantity: params[:quantity], product_id: params[:product_id])
  	@order.save
    session[:order_id] = @order.id

    line_item.update(line_item_total: (line_item.quantity * line_item.product.price))
  	redirect_back(fallback_location: root_path)
  end

  def view_cart
  	@items = current_order.line_items
  end

  def checkout
  	items = current_order.line_items

    if (items.length > 0)
    	current_order.update(user_id: current_user.id, sub_total: 0)
      @order = current_order

  	items.each do |item|
  		item.product.update(quantity:(item.product.quantity - item.quantity))
  		@order.order_items[item.product_id] = item.quantity
  		@order.sub_total += item.line_item_total
	  end
  	@order.save  	

  	@order.update(sales_tax: (@order.sub_total * 0.07))
  	@order.update(grand_total: (@order.sub_total + @order.sales_tax))
    	
  	@order.line_items.destroy
    session[:order_id] = nil
    end

  end

  def order_complete
    @order = Order.find(params[:order_id])
    @amount = (@order.grand_total.to_f.round(2) * 100).to_i

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card => params[:stripeToken]
      )
    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => @amount,
      :description => 'Rails Stripe Customer',
      :currency => 'usd'
      )
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to cart_path
  end
end
