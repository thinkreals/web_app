class PropertiesController < ApplicationController
  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.page(params[:page]).per(params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render_collection_json @properties }
    end
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    @property = Property.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @property }
    end
  end

  # GET /properties/new
  # GET /properties/new.json
  def new
    @property = Property.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @property }
    end
  end

  # GET /properties/1/edit
  def edit
    @property = Property.find(params[:id])
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(params[:property])

    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render json: @property, status: :created, location: @property }
      else
        format.html { render action: "new" }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /properties/1
  # PUT /properties/1.json
  def update
    @property = Property.find(params[:id])

    respond_to do |format|
      if @property.update_attributes(params[:property])
        format.html { redirect_to @property, notice: 'Property was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property = Property.find(params[:id])
    @property.destroy

    respond_to do |format|
      format.html { redirect_to properties_url }
      format.json { head :ok }
    end
  end
end
