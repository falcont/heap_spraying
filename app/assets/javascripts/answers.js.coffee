answer_func = ->
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