class ProductsController < ApplicationController

    def find_by_sku
        @product = Product.find(params[:sku])
    end
end
