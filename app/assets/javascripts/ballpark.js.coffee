# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(($)->
  $('#form_calc')
    .live("ajax:complete", (xhr)->
      $('#result').append('<div>Done.</div>')
    )
    .live("ajax:beforeSend", (xhr)->
      $('#result').html('<div>Loading...</div>')
    )
    .live("ajax:success", (event, data, status, xhr)->
      alert (data.cost)
      $('#result').html(data.cost)
    )
    .live("ajax:error", (data, status, xhr)->
      alert("failure!!!")
    )
)
