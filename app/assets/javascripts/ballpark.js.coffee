# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(($)->
  $('#form_calc')
    .live("ajax:complete", (xhr)->
      $('#result').append('<div>Done.</div>')
    )
    .live("ajax:beforeSend", (xhr)->
      $('#result').empty()
      $('#result').append('<div>Loading...</div>')
    )
    .live("ajax:success", (event, data, status, xhr)->
      $('#result').empty()
      $('#result').append(data.result)
    )
    .live("ajax:error", (data, status, xhr)->
      alert("failure!!!")
    )
)
