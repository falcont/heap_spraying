answer_func = ->

  $('.answers').on('click', '.edit-answer-link', (e)->
    e.preventDefault()
    answer_id = $(this).data('answerId')
    $("form#edit-answer-#{answer_id}").show()
  );



  App.cable.subscriptions.create('AnswersChannel', {
    connected: ->
      console.log 'Connected!'
      @perform 'follow'
    ,

    received: (data) ->
      console.log data
      questionsList.append data

  })

$(document).on('ready', answer_func);
$(document).on('turbolinks:load', answer_func);