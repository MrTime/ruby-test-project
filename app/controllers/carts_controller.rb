class CartsController < ApplicationController

  # GET /carts
  def index
    @carts = Cart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carts }
    end
  end

  # GET /carts/1
  def show
    begin
      @cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid carts #{params[:id]}"
      redirect_to root_path, notice: 'Invalid carts'
    else
      respond_to do |format|
        format.html # show.html.erb
      end
    end
  end

  # GET /carts/new
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /carts/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end

  # POST /carts
  def create
    @cart = Cart.new(params[:carts])

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /carts/1
  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:carts])
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /carts/1
  def destroy
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil
    respond_to do |format|
      format.html { redirect_to books_path, notice: 'Your cart successfully cleared' }
    end
  end

end
