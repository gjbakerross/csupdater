class Project < ApplicationRecord
    require 'csv'
    include Rails.application.routes.url_helpers

    has_one_attached :main_image
    has_many_attached :step_images

    before_create :add_template_url, :add_country_to_id, :format_instructions, :format_skus, :save_main_image_link, :save_step_images
    
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
            shoppinglist.push("<a href=\"#{product.url}\">#{product.title}</a>")
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

    def save_main_image_link
        self.mainimage = self.main_image.filename.to_s
    end

    def save_step_images
        self.image1 = self.step_images[0].filename.to_s
        self.image2 = self.step_images[1].filename.to_s
        self.image3 = self.step_images[2].filename.to_s
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
        attributes = %w(uniqueid title products core_products)
    
        CSV.generate(headers: true) do |csv|
          csv << attributes
    
          all.each do |project|
            csv << attributes.map{ |attr| project.send(attr) }
          end
        end
    end

    # def send_to_wordpress
    #     url = 'http://bakerross-wp.thepixel.host/creative-station/wp-json/wp/v2/media'
    #     username = Rails.application.credentials.dig(:wordpress, :user) 
    #     password = Rails.application.credentials.dig(:wordpress, :password) 
    #     conn = Faraday.new(
    #         url: "#{url}"
    #         headers: {
    #             'Content-Disposition' => 'form-data; filename="example.jpg"'
    #             'Content-Type' => 'image/jpeg'
    #         }
    #     ) do |f|
    #         f.request :multipart
    #         f.request :url_encoded
    #     end
    #     conn.basic_auth(ActiveSupport::Base64.encode64(username)},ActiveSupport::Base64.encode64(password))
    #     mi = Faraday::UploadIO.new(url_for(self.main_image),"image/jpeg")
    #     payload = {:file => file}
    #     conn.post('/', payload)
    # end

end
