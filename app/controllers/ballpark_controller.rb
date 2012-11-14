class BallparkController < ApplicationController
  def index
    @rdc_servers = RdcServer.all(:order => "typename")
    @rs = params[:rs].inspect
    render
  end

  def calc
    @rs = params[:rs].inspect
    render :json => {:result => @rs}
  end

end
