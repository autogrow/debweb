class DebfilesController < ApplicationController
  before_action :set_debfile, only: [:show, :edit, :update, :destroy]

  # GET /debfiles
  # GET /debfiles.json
  def index
    @debfiles = Debfile.all
  end

  # GET /debfiles/1
  # GET /debfiles/1.json
  def show
  end

  # GET /debfiles/new
  def new
    @debfile = Debfile.new
  end

  # GET /debfiles/1/edit
  def edit
  end

  # POST /debfiles
  # POST /debfiles.json
  def create
    @debfile = Debfile.new(debfile_params)

    respond_to do |format|
      if @debfile.save
        format.html { redirect_to @debfile, notice: 'Debfile was successfully created.' }
        format.json { render :show, status: :created, location: @debfile }
      else
        format.html { render :new }
        format.json { render json: @debfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /debfiles/1
  # PATCH/PUT /debfiles/1.json
  def update
    respond_to do |format|
      if @debfile.update(debfile_params)
        format.html { redirect_to @debfile, notice: 'Debfile was successfully updated.' }
        format.json { render :show, status: :ok, location: @debfile }
      else
        format.html { render :edit }
        format.json { render json: @debfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debfiles/1
  # DELETE /debfiles/1.json
  def destroy
    @debfile.destroy
    respond_to do |format|
      format.html { redirect_to debfiles_url, notice: 'Debfile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upload
    log = Logger.new Rails.root.join('log', 'uploads.log')
    io  = params[:debfile]
    log.info "Receiving #{io.original_filename} from #{current_user.email}"
    
    filename = Rails.root.join('public', 'uploads', io.original_filename)

    File.open(filename, 'wb') do |file|
      file.write(io.read)
    end
    log.info "Saved #{io.original_filename} to uploads folder"

    svc = Services::UploadedFileImporter.new(filename, log)
    svc.process(Library.new)

    render :nothing, status: 200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debfile
      @debfile = Debfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def debfile_params
      params.require(:debfile).permit(:name, :control, :version)
    end
end
