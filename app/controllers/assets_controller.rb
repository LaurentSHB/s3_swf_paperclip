class AssetsController < ApplicationController
  def index
    @assets = Asset.all
  end

  def create
    asset = Asset.new(params[:asset])
    asset.save
    redirect_to assets_path
  end
end
