class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @addresses = Address.where(customer: current_customer)
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = current_customer.orders.new(order_params)

    if params[:order][:addresses] == "residence"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:addresses] == "registration"
      address = Address.find(params[:order][:address_id])
      @order.postal_code = address.postal_code
      @order.address = address.address
      @order.name = address.name
    elsif params[:order][:addresses] == "new_address"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      @address = "1"
    end
  end

  def thanks
  end

  def definition
    @order = current_customer.orders.new(order_params)
    @cart_items = current_customer.cart_items.all
    if  @order.save
        @cart_items.each do |cart_item|
          @order_items = @order.order_items.new
          @order_items.item_id = cart_item.item.id
          # @order_items.name = cart_item.item.name
          @order_items.price = cart_item.item.price
          @order_items.amount = cart_item.amount
          @order_items.save
        end
      current_customer.cart_items.destroy_all
      flash[:notice] = "ご注文が確定しました。"
      redirect_to thanks_orders_path
    else
      @address = current_customer.addresses.all
      render :new
    end
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end


  private
  def order_params
    params.require(:order).permit(:price, :payment_method, :postal_code, :address, :name)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end

  def to_confirm
    redirect_to items_path if params[:id] == "confirm"
  end

end
