class AssetsController < ApplicationController
  def index
    @assets = Asset.all
  end

  def create
    asset = Asset.new(params[:asset])
    asset.save
    redirect_to assets_path
  end

  def create_some
    @asset = Asset.new(params[:asset])

    respond_to do |format|
      if @asset.save
        format.js  {render :text => 'ok' } # crazy cool stuff here
      else
        format.js  { render :text => 'alert("Failure from Rails!");' }
      end
    end
  end
end
