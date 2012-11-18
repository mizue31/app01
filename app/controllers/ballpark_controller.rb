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
    results = Hash.new
    params[:rs].each do |id, n|
      results['item'] = @rdc_servers[id.to_i]['typename']
      results['num']  = n['num']
      results['cost'] = @rdc_servers[id.to_i]['cost1'] * n['num'].to_i
      total  += results['cost']
      output = {'item'=>results['item'], 'num'=>results['num'], 'cost'=>results['cost']}
      j = JSON::pretty_generate(output)

    end

    render :json => output
    #render :json => {"aaa": "bbb"}
    #render json: {:data => output}
    #render :json=> {:result=>j.to_s}

  end

end
