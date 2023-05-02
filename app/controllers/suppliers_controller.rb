class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
  end

  def show
    @supplier = Supplier.find(params[:id])
   # @products = @supplier.products
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)

    if @supplier.save
      redirect_to @supplier
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def update
    @supplier = Supplier.find(params[:id])

    if @supplier.update(supplier_params)
      redirect_to @supplier
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    supplier = Supplier.find(params[:id])
    supplier.destroy

    redirect_to suppliers_path
  end

  private

  def supplier_params
    params.require(:supplier).permit(:name, :phone_number, :email, :contact_full_name, :contact_phone_number, :contact_email, :comment)
  end
end
