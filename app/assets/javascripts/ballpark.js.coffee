# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(($)->
  $('#form_calc')
    .live("ajax:complete", (xhr)->
      #alert("done")
      #$('#result').append('<div>Done.</div>')
    )
    .live("ajax:beforeSend", (xhr)->
      $('#result').html('<div>Loading...</div>')
    )
    .live("ajax:success", (event, data, status, xhr)->
      $('#result').html('<div>Success1...</div>')
#      output_html=""
#      [output_html, total1, total2] = hardware(data['hw'])
#      output_html += software(data['sw'], total1, total2)
#      output_html += outsource(data['outsource'], total1+total2)
#      output_html += fte(data['fte'], total1+total2)
      $('#result').html('<div>Success2...</div>')

      $('#result').empty()
      $('#result').append(data)
#      $('#result').html(output_html)
    )
    .live("ajax:error", (data, status, xhr)->
      alert("failure!!!")
    )
)

hardware=(data)->
      total1=0
      total2=0
      cost=0
      html = "<table id='result_tbl' class='result_tbl'>"
      html += '''
            <col class="vm type" />
            <col class="num(prod)" />
            <col class="num(non-prod)" />
            <col class="cost(prod)" />
            <col class="cost(non-prod)" />
            <tr>
            <td class=title colspan=5 align=center>hardware</td>
            </tr>
            <tr>
            <th>hw item</th>
            <th>num(prod)</th>
            <th>num(non-prod)</th>
            <th>arc(prod)</th>
            <th>arc(non-prod)</th>
            </tr>
'''
      for o in data
        if o['num1'] isnt "0" or o['num2'] isnt "0"
          html += "<tr><td>#{o['item']}(#{o['spec']})</td>"
          html += "<td>#{o['num1']}</td>"
          html += "<td>#{o['num2']}</td>"
          html += "<td>#{o['cost1']}</td>"
          html += "<td>#{o['cost2']}</td></tr>"
          total1 += parseInt(o['num1'])
          total2 += parseInt(o['num2'])

      html += "<tr><td>total arc</td><td colspan=4>"
      html += o['total_cost']
      html += "</td></tr>"
      html += "</table>"
      [html,total1,total2]
    
software=(data, n1, n2)->
      html = "<table id='result_tbl' class='result_tbl'>"
      html += """
            <tr>
            <td class=title colspan=4 align=center>software</td>
            </tr>
            <tr>
            <th>sw item</th>
            <th>num</th>
            <th>init</th>
            <th>arc</th>
            </tr>
"""
      for o in data
        if n1 isnt 0 or n2 isnt 0
          html += "<tr><td>#{o['item']}</td>"
          html += "<td>#{o['num']}</td>"
          html += "<td>#{o['init']}</td>"
          html += "<td>#{o['recr']}</td></tr>"

      html += "<tr><td colspan=2>total</td>"
      html += "<td>#{o['cost_init']}</td>"
      html += "<td>#{o['cost_recr']}</td></tr>"
      html += "</table>"

fte=(data, n)->
      html = "<table id='result_tbl' class='result_tbl'>"
      o = data[0]

      html += """
            <tr>
            <td class=title colspan=5 align=center>fte</td>
            </tr>
            <tr>
            <th>resource</th>
            <th>phase 2</th>
            <th>phase 3</th>
            <th>phase 4</th>
            <th>recurring</th>
            </tr>
            <tr>
            <td>#{o['item']}</td>
            <td>#{o['ph2']}</td>
            <td>#{o['ph3']}</td>
            <td>#{o['ph4']}</td>
            <td>#{o['arc']}</td>
            </tr>
            </table>
"""

outsource=(data, n)->
      html = "<table id='result_tbl' class='result_tbl'>"
      o = data[0]

      html += """
            <tr>
            <td class=title colspan=2 align=center>outsource service</td>
            </tr>
            <tr>
            <th>outsource</th>
            <th>cost</th>
            </tr>
            <tr>
            <td>#{o['item']}</td>
            <td>#{o['init']}</td>
            </tr>
            </table>
"""
