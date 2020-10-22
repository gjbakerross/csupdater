class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
 
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.search(params[:search])
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  def export_projects
    
    @projects = Project.where(created_at:(Export.last.created_at)...Time.now)
    # @projects = Project.all
    send_data @projects.to_project_csv, filename: "projects-#{Date.today}.csv"
    # download_images(@projects)
    Export.create
    # redirect_to action: "index" and return 
  end

  def export_products
    # redirect_to :index
    @projects = Project.all
    send_data @projects.to_product_csv, filename: "product-#{Date.today}.csv"
    
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    # @project = Project.new(project_params)
    # @project.template = "www.bakerross.co.uk/patticrafts/" + @project.template

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:search, :title,:uniqueid,:intro, :main_image,:template, :supervision, :products, :core_products, :categories, :level,:time,:how_to_make, :what_youll_need, :tip,:tags, :language_id, :youtube, step_images:[])
    end

    
  def download_images(projects)
    tmp_project_folder = "tmp/archive_#{Date.today.to_s}"
      projects.each do |project|
          directory_length_same_as_images = Dir["#{tmp_project_folder}/*"].length == (project.step_images.length)
          step = project.step_images 
          FileUtils.mkdir_p(tmp_project_folder) unless Dir.exists?(tmp_project_folder) 
          step.each do |step_image|
              step_filename = step_image.filename.to_s
              create_tmp_folder_and_store_documents(step_image,tmp_project_folder,step_filename) unless directory_length_same_as_images
              create_zip_from_tmp_folder(tmp_project_folder, step_filename) unless directory_length_same_as_images
          end
          mainimagefilename = project.main_image.filename.to_s
          create_tmp_folder_and_store_documents(project.main_image,tmp_project_folder,mainimagefilename) 
          create_zip_from_tmp_folder(tmp_project_folder, mainimagefilename) 
          send_file(Rails.root.join("#{tmp_project_folder}.zip"), :type => 'application/zip', :filename => "Files.zip", :disposition => 'attachment')
      end
      
  end

  def create_tmp_folder_and_store_documents(document, tmp_project_folder, filename)
      File.open(File.join(tmp_project_folder, filename), 'wb') do |file|
       document.download { |chunk| file.write(chunk) }
      end
    end
    
  def create_zip_from_tmp_folder(tmp_project_folder, filename)
      Zip::File.open("#{tmp_project_folder}.zip", Zip::File::CREATE) do |zf|
        zf.add(filename, "#{tmp_project_folder}/#{filename}")
      end
  end

      
end
