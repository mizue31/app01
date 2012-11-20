# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(($)->
  $('#form_calc')
    .live("ajax:complete", (xhr)->
      alert("done")
      #$('#result').append('<div>Done.</div>')
    )
    .live("ajax:beforeSend", (xhr)->
      $('#result').html('<div>Loading...</div>')
    )
    .live("ajax:success", (event, data, status, xhr)->
      html = "<col class='type' /><col class='spec' /><col class='num /><col class='cost' />"
      html = html + "<tr><th>type</th><th>spec</th><th>num</th><th>cost</th></tr>"
      for o in data
        html = html + "<tr><td>#{o["item"]}</td>"
        html = html + "<td>#{o["spec"]}</td>"
        html = html + "<td>#{o["num"]}</td>"
        html = html + "<td>#{o["cost"]}</td></tr>"
        # (for debug) alert("#{o["item"]}#{o["num"]}#{o["cost"]}")
      $('#result').html(html)
    )
    .live("ajax:error", (data, status, xhr)->
      alert("failure!!!")
    )
)
