class ProductsController < ApplicationController
    
    def index        
    end

    def create
        uploaded_file = params[:product_csv]
        Product.import_products(uploaded_file)
    end

    def find_by_sku
        @product = Product.find(params[:sku])
    end

    # def upload
    #     uploaded_file = params[:product_csv]
    #     Product.import_products(uploaded_file)
    # end

    def product_params
        params.require(:product).permit(:product_csv)
    end
    
end
