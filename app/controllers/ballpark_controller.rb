class BallparkController < ApplicationController
  def index
    @rdc_servers = RdcServer.all(:order => "typename")
  end

  def calc
  end
end
