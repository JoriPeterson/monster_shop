class OrdersController < ApplicationController

	def index
		@orders = current_user.orders
	end

  def show
		@order = Order.find(params[:id])
  end

  def new
  end

  def create
    @user = current_user
    @order = @user.orders.new(order_params)
    if @order.save
      cart.items.each do |item|
        @order.order_items.create({
          item: item,
          quantity: cart.count_of(item.id),
          price: item.price
          })
      end
      session.delete(:cart)
			flash[:success] = "Your order was created"
      redirect_to "/profile/orders"
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end

	def update
		@order = Order.find(params[:id])
		@order.cancel_order
	end

  private

  def order_params
    params.permit(:status, :user_id)
  end
end
