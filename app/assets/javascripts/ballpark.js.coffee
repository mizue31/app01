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
      output_html=""
      [output_html, total] = hardware(data['hw'])
      output_html += software(data['sw'], total)
      output_html += fte(data['fte'], total)
      output_html += outsource(data['outsource'], total)

      $('#result').html(output_html)
    )
    .live("ajax:error", (data, status, xhr)->
      alert("failure!!!")
    )
)

hardware=(data)->
      total=0
      html = "<table id='result_tbl' class='result_tbl'>"
      html += '''
            <col class="VM type" />
            <col class="num" />
            <col class="cost" />
            <tr>
            <td class=title colspan=4 align=center>hardware</td>
            </tr>
            <tr>
            <th>VM type</th>
            <th>num</th>
            <th>arc(with DR)</th>
            </tr>
'''
      for o in data
        if o['num'] isnt "0"
          html += "<tr><td>#{o['item']}(#{o['spec']})</td>"
          html += "<td>#{o['num']}</td>"
          html += "<td>#{o['cost']}</td></tr>"
          total += parseInt(o['num'])

      html += "</table>"
      [html,total]
    
software=(data, n)->
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
        if n isnt 0
          html += "<tr><td>#{o['item']}</td>"
          html += "<td>#{n}</td>"
          html += "<td>#{o['init']}</td>"
          html += "<td>#{o['recr']}</td></tr>"
      html += "</table>"

fte=(data, n)->
      html = "<table id='result_tbl' class='result_tbl'>"
      o = data[0]

      html += """
            <tr>
            <td class=title colspan=4 align=center>fte</td>
            </tr>
            <tr>
            <th>resource</th>
            <th>phase 2</th>
            <th>phase 3</th>
            <th>phase 4</th>
            </tr>
            <tr>
            <td>#{o['item']}</td>
            <td>#{o['ph2']}</td>
            <td>#{o['ph3']}</td>
            <td>#{o['ph4']}</td>
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
