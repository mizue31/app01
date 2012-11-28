class BallparkController < ApplicationController
  def index
    @rdc_servers = RdcServer.all(:order => "typename")
    render
  end

  def currency (number)
    ActionController::Base.helpers.number_to_currency(number, :unit=>'JPY', :precision=>0, :format=>"%u %n")
  end

  def calc
    @sw = [
        {'item'=>'CA Access Control', 'init'=>224.91, 'recr'=>44.98},
        {'item'=>'RSA enVision',      'init'=>0,      'recr'=>28.85},
        {'item'=>'Tripwire',          'init'=>537,    'recr'=>107.4},
        {'item'=>'Symantec EPP',      'init'=>0,      'recr'=>369},
        {'item'=>'Qualys Guard',      'init'=>0,      'recr'=>23},
    ]
    @fte = [
        {'item'=>'Distributed', 'ph2'=>75000, 'ph3'=>75000, 'ph4'=>75000}
    ]
    @outsource = [
        {'item'=>'ATSS', 'init'=>75000}
    ]

    @rdc_servers = RdcServer.all(:order => "typename")
    @rs = params[:rs].inspect
    @sgd_rate = params[:sgd_rate]
    @usd_rate = params[:usd_rate]

    total = 0
    total_num = 0
    #output = ""
    output = Hash.new
    res = Hash.new
    hw = Array.new
    o = Hash.new
    params[:rs].each do |id, n|
      res['item'] = @rdc_servers[id.to_i]['typename']
      res['spec'] = @rdc_servers[id.to_i]['spec']
      res['num']  = n['num']
      res['cost'] = @rdc_servers[id.to_i]['cost1'] * n['num'].to_i * @sgd_rate.to_i
      total  += res['cost']
      total_num  += n['num'].to_i
      res['cost'] = currency(res['cost'])
      output = {'item'=>res['item'], 'spec'=>res['spec'], 'num'=>res['num'], 'cost'=>res['cost'] }
      hw[id.to_i] = output
    end
    o['hw'] = hw
    
    @sw.each_with_index do |elem, i|
      @sw[i]['init'] = currency(@usd_rate.to_i * elem['init'] * total_num)
      @sw[i]['recr'] = currency(@usd_rate.to_i * elem['recr'] * total_num)
    end
    o['sw'] = @sw

    @fte[0]['ph2'] = currency(@fte[0]['ph2'] * total_num * 2)
    @fte[0]['ph3'] = currency(@fte[0]['ph3'] * total_num)
    @fte[0]['ph4'] = currency(@fte[0]['ph4'] * total_num * 5)
    o['fte'] = @fte

    @outsource[0]['init'] = currency(@outsource[0]['init'] * total_num * 5)
    o['outsource'] = @outsource

    render :json => o
  end

end
