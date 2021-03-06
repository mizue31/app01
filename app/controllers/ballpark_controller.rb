# Ballpark class body
class BallparkController < ApplicationController
  # Ballpark controller class

  JPY = 'JPY'
  SGD = 'SGD'
  USD = 'USD'

  def rdcserver_params
    params.require(:RdcServer).permit(:cost1, :cost2, :spec, :typename, :num1, :num2)
  end
  def index
    # index page for startup
    #@rdc_servers = RdcServer.all(:order => "typename")
    @rdc_servers = RdcServer.order("typename").load
    render
  end

  def convert_to_JPY (number, from)
    # change format of currency to 'JPY'
    #   JPY -> JPY
    #   SGD -> JPY
    #   USD -> JPY
    if from != JPY
      case from
        when SGD then
          number = number * @sgd_rate.to_i
        when USD then
          number = number * @usd_rate.to_i
      end
    end
    ActionController::Base.helpers.number_to_currency(number, :unit=>JPY, :precision=>2, :format=>"%u %n")
  end

  def calc
    # calculation main procedure

    @san = [
        {'item'=>'SAN Storage', 'spec'=>'Tier2', 'cost1'=>12.58, 'cost2'=>7.37}
    ]

    # sw cost is based on USD
    @sw = [
        {'item'=>'Access Control(CA AC)', 'target'=>'prod', 'num'=>0, 'init'=>224.91, 'recr'=>44.98},
        {'item'=>'Log Monitoring(RSA enVision)',      'target'=>'prod', 'num'=>0, 'init'=>0,      'recr'=>28.85},
        {'item'=>'Anti Virus(Symantec EPP)',      'target'=>'all',  'num'=>0, 'init'=>0,      'recr'=>369},
        {'item'=>'Vulnerability Management(QualysGuard VM)',      'target'=>'all',  'num'=>0, 'init'=>0,      'recr'=>23},
        {'item'=>'Configuration Policy Compliance(QualysGuard PCM)',          'target'=>'prod', 'num'=>0, 'init'=>0,    'recr'=>16},
    ]
    # QualysGuard PCM => 16USD/server/year => 20SGD/server/year

    @fte = [
        {'item'=>'Distributed', 'ph2'=>70000, 'ph3'=>70000, 'ph4'=>70000, 'arc'=>60500},
        {'item'=>'Networks', 'ph2'=>70000, 'ph3'=>0, 'ph4'=>0, 'arc'=>0},
        {'item'=>'Workplaces', 'ph2'=>70000, 'ph3'=>0, 'ph4'=>0, 'arc'=>0},
        {'item'=>'App Service', 'ph2'=>70000, 'ph3'=>0, 'ph4'=>0, 'arc'=>0},
        {'item'=>'Mainframe', 'ph2'=>70000, 'ph3'=>0, 'ph4'=>0, 'arc'=>0},
        {'item'=>'GRSC', 'ph2'=>70000, 'ph3'=>0, 'ph4'=>0, 'arc'=>0},
        {'item'=>'PM', 'ph2'=>140000, 'ph3'=>70000, 'ph4'=>35000, 'arc'=>0},
        {'item'=>'SDA', 'ph2'=>70000, 'ph3'=>0, 'ph4'=>0, 'arc'=>0}
    ]

    # DR unit cost = 419 SGD per production server
    dr_unit_cost = 419

    @outsource = [
        {'item'=>'ATSS', 'init'=>110000}
    ]

    @rdc_servers = RdcServer.all(:order => "typename")
    @rs = params[:rs].inspect
    @sgd_rate = params[:sgd_rate]
    @usd_rate = params[:usd_rate]
    @san_num1 = params[:san_num1]
    @san_num2 = params[:san_num2]

    total_num = 0
    total_num1 = 0
    total_num2 = 0
    total_cost = 0
    output = Hash.new
    res = Hash.new
    hw = Array.new
    o = Hash.new
    index = 0
    params[:rs].each do |id, n|
      res['item'] = @rdc_servers[id.to_i]['typename']
      res['spec'] = @rdc_servers[id.to_i]['spec']
      res['num1']  = n['num1'] # num of prod servers
      res['num2']  = n['num2'] # num of non-prod servers
      res['cost1'] = @rdc_servers[id.to_i]['cost1'] * n['num1'].to_i
      res['cost2'] = @rdc_servers[id.to_i]['cost2'] * n['num2'].to_i
      total_num1  += n['num1'].to_i
      total_num2  += n['num2'].to_i
      total_cost += res['cost1'] + res['cost2']

      res['cost1'] = convert_to_JPY(res['cost1'], SGD)
      res['cost2'] = convert_to_JPY(res['cost2'], SGD)
      output = {'item'=>res['item'], 'spec'=>res['spec'], 'num1'=>res['num1'], 'num2'=>res['num2'], 'cost1'=>res['cost1'], 'cost2'=>res['cost2'] }
      hw[id.to_i] = output
      index = id.to_i
    end
    total_num = total_num1 + total_num2

    @san[0]['cost1'] = @san[0]['cost1'] * @san_num1.to_i
    @san[0]['cost2'] = @san[0]['cost2'] * @san_num2.to_i
    total_cost += @san[0]['cost1'] + @san[0]['cost2']
    @san[0]['cost1'] = convert_to_JPY(@san[0]['cost1'], SGD)
    @san[0]['cost2'] = convert_to_JPY(@san[0]['cost2'], SGD)
    total_cost = convert_to_JPY(total_cost, SGD)
    hw[index+1] = {'item'=>@san[0]['item'], 'spec'=>@san[0]['spec'], 'num1'=>@san_num1, 'num2'=>@san_num2, 'cost1'=>@san[0]['cost1'], 'cost2'=>@san[0]['cost2'] }

    o['hw'] = hw
    o['hw_total_cost'] = total_cost
    
    # DR costing
    o['dr'] = convert_to_JPY(total_num1 * dr_unit_cost, SGD)
    
    # SW costing
    cost_init = 0
    cost_recr = 0
    @sw.each_with_index do |elem, i|
      if @sw[i]['target'] == 'prod'
        @sw[i]['num'] = total_num1
        cost_init += elem['init'] * total_num1
        cost_recr += elem['recr'] * total_num1
        @sw[i]['init'] = convert_to_JPY(elem['init'] * total_num1, USD)
        @sw[i]['recr'] = convert_to_JPY(elem['recr'] * total_num1, USD)
      elsif @sw[i]['target'] == 'all'
        @sw[i]['num'] = total_num1 + total_num2
        cost_init += elem['init'] * (total_num1+total_num2)
        cost_recr += elem['recr'] * (total_num1+total_num2)
        @sw[i]['init'] = convert_to_JPY(elem['init'] * (total_num1+total_num2), USD)
        @sw[i]['recr'] = convert_to_JPY(elem['recr'] * (total_num1+total_num2), USD)
      end
      @sw[0]['cost_init'] = convert_to_JPY(cost_init, USD)
      @sw[0]['cost_recr'] = convert_to_JPY(cost_recr, USD)
    end
    o['sw'] = @sw

    # FTE costing
    #@fte[0]['ph2'] = convert_to_JPY(@fte[0]['ph2'] * total_num * 2, JPY)
    #@fte[0]['ph3'] = convert_to_JPY(@fte[0]['ph3'] * total_num, JPY)
    #@fte[0]['ph4'] = convert_to_JPY(@fte[0]['ph4'] * total_num * 5, JPY)
    #@fte[0]['arc'] = convert_to_JPY(@fte[0]['arc'] * total_num, JPY)

    @fte.each_with_index do |elem,i|
        elem['ph2'] = convert_to_JPY(elem['ph2'] * 5, JPY)
        elem['ph3'] = convert_to_JPY(elem['ph3'] * 5, JPY)
        elem['ph4'] = convert_to_JPY(elem['ph4'] * total_num * 5, JPY)
        elem['arc'] = convert_to_JPY(elem['arc'] * total_num, JPY)
    end
    o['fte'] = @fte

    @outsource[0]['init'] = convert_to_JPY(@outsource[0]['init'] * total_num, JPY)
    o['outsource'] = @outsource
    @result_data = o

    render :partial => "calc"
  end

end
