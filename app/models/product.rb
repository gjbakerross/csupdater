class Product < ApplicationRecord

    require 'csv'
    def self.import_products (csv)
        csv_text = File.read(csv)
        parsed_text = CSV.parse(csv_text, :headers => true)
        parsed_text.each do |row|
            p = Product.new
            p.title = row[0]
            p.sku = row['sku']
            p.url = row['url']
            p.save
        end
    end
end
