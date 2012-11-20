class BallparkController < ApplicationController
  def index
    @rdc_servers = RdcServer.all(:order => "typename")
    render
  end

  def calc
    @rdc_servers = RdcServer.all(:order => "typename")
    @rs = params[:rs].inspect
    total = 0
    #output = ""
    output = Hash.new
    res = Hash.new
    j = Array.new
    params[:rs].each do |id, n|
      res['item'] = @rdc_servers[id.to_i]['typename']
      res['spec'] = @rdc_servers[id.to_i]['spec']
      res['num']  = n['num']
      res['cost'] = @rdc_servers[id.to_i]['cost1'] * n['num'].to_i
      total  += res['cost']
      output = {'item'=>res['item'], 'spec'=>res['spec'], 'num'=>res['num'], 'cost'=>res['cost']}
      j[id.to_i] = output
    end

    render :json => j
  end

end
