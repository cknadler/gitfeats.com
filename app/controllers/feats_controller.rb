class FeatsController < ApplicationController
  # GET /feats
  # GET /feats.json
  def index
    @feats = Feat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feats }
    end
  end

  # GET /feats/1
  # GET /feats/1.json
  def show
    @feat = Feat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feat }
    end
  end

  # GET /feats/new
  # GET /feats/new.json
  def new
    @feat = Feat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feat }
    end
  end

  # GET /feats/1/edit
  def edit
    @feat = Feat.find(params[:id])
  end

  # POST /feats
  # POST /feats.json
  def create
    @feat = Feat.new(params[:feat])

    respond_to do |format|
      if @feat.save
        format.html { redirect_to @feat, notice: 'Feat was successfully created.' }
        format.json { render json: @feat, status: :created, location: @feat }
      else
        format.html { render action: "new" }
        format.json { render json: @feat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /feats/1
  # PUT /feats/1.json
  def update
    @feat = Feat.find(params[:id])

    respond_to do |format|
      if @feat.update_attributes(params[:feat])
        format.html { redirect_to @feat, notice: 'Feat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @feat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feats/1
  # DELETE /feats/1.json
  def destroy
    @feat = Feat.find(params[:id])
    @feat.destroy

    respond_to do |format|
      format.html { redirect_to feats_url }
      format.json { head :no_content }
    end
  end
end
