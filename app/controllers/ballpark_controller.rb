class BallparkController < ApplicationController
  def index
    @rdc_servers = RdcServer.all(:order => "typename")
    # @rs = params[:rs].inspect
    render
  end

  def calc
    @rdc_servers = RdcServers.all(:order => "typenames)
    @rs = params[:rs].inspect
    for n in params[:rs]
      cost = cost + n['num']
    render :json => {:result => @rs + cost}
  end

end
