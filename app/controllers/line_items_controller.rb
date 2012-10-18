class LineItemsController < ApplicationController

  # GET /line_items
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /line_items/1
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  def create
    @cart = current_cart
    book = Book.find(params[:book_id])
    @line_item = @cart.add_book(book.id)
    respond_to do |format|
      if @line_item.save
        flash[:success] = "Book was successfully added to cart"
        format.html { redirect_to :back }
        format.js {  @current_item = @line_item}
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /line_items/1
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to line_items_url }
    end
  end
end
