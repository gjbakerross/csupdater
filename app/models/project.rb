class Project < ApplicationRecord
    require 'csv'

    before_create :add_template_url, :add_country_to_id, :format_instructions, :format_skus
    
    def add_template_url
        self.template = "www.bakerross.co.uk/patticrafts/" + self.template
    end
    
    def add_country_to_id
        self.uniqueid = self.uniqueid + "_en"
    end
    
    def format_instructions
        instructions = self.format_list(self.how_to_make, "ordered","\n")
        self.how_to_make = instructions
    end

    def format_skus
        skulist = self.products.split(",")
        shoppinglist=[]
        skulist.each do |item|
            product = Product.find_by_sku(item)
            shoppinglist.push("<a href=\"#{product.url}\">#{product.title}")
        end
        
        if self.what_youll_need.present?
            shoppinglist = shoppinglist.join(",") 
            shoppinglist += "," + self.what_youll_need
            self.add_what_youll_need
        end
        self.shopping_list = self.format_list(shoppinglist ,"unordered",",")    
    end

    def add_what_youll_need
        wyn = self.format_list(self.what_youll_need,"unordered",",")
        self.what_youll_need = wyn
    end

    def format_list(list, option,char)
        final_list = list.split(char)
        outcome = ""
        if option == "ordered" 
            outcome += "<ol>"
        elsif option == "unordered"
            outcome += "<ul>"
        end

        final_list.each do |item|
            item = "<li>"+ item + "</li>"
            outcome += item
        end

        if option == "ordered" 
            outcome += "</ol>"
        elsif option == "unordered"
            outcome += "</ul>"
        end

        return outcome
    end

    def self.to_project_csv
        attributes = %w(uniqueid title intro mainimage image1 image2 image3 level time how_to_make shopping_list what_youll_need tip template tags supervision products categories)
    
        CSV.generate(headers: true) do |csv|
          csv << attributes
    
          all.each do |project|
            csv << attributes.map{ |attr| project.send(attr) }
          end
        end
    end

    def self.to_product_csv
        attributes = %w(uniqueid title products)
    
        CSV.generate(headers: true) do |csv|
          csv << attributes
    
          all.each do |project|
            csv << attributes.map{ |attr| project.send(attr) }
          end
        end
    end

end
