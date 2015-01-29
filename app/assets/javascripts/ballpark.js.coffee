# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(($)->
  $('#form_calc')
    .on("ajax:complete", (xhr)->
      #alert("done")
      #$('#result').append('<div>Done.</div>')
    )
    .on("ajax:beforeSend", (xhr)->
      $('#result').html('<div>Loading...</div>')
    )
    .on("ajax:success", (event, data, status, xhr)->
      $('#result').html('<div>Success1...</div>')
      $('#result').empty()
      $('#result').html(data)
    )
    .on("ajax:error", (data, status, xhr)->
      alert("failure!!!")
    )
)
