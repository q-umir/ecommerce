class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_product, only: %i[ show edit update destroy ]

  def index
      @products = Product.all
  end

  def show
    @review = Review.new
    @shopping_cart_product = ShoppingCartProduct.new
    if user_signed_in?
      @reviews = @product.reviews.order('created_at DESC').includes([:user])
    else
      @reviews = @product.reviews.order('created_at DESC')
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to product_url(@product), notice: "Producto creado"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to product_url(@product)
    else
      render :edit
    end
  end

  def destroy
    # verificando si el producto esta en algun carrito activo
    if ShoppingCartProduct.joins(:shopping_cart).where(shopping_cart: {active: true}).pluck('product_id').uniq.include?(params[:id].to_i)
      redirect_to products_url, notice: 'No se pudo eliminar porque esta en un carrito'
    else
      @product.destroy
      redirect_to products_url, notice: 'Producto eliminado'
    end
  end


  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :code, :stock, :price, :description, :category_id)
  end
end
