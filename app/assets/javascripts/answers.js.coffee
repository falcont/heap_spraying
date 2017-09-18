answer_func = ->
  $('.answers').on('click', '.edit-answer-link', (e)->
    e.preventDefault()
    answer_id = $(this).data('answerId')
    $("form#edit-answer-#{answer_id}").show()
  );

  questionId = $('.answers').data('questionId')
  channel = '/questions/' + questionId + '/answers'

  App.cable.subscriptions.create({ channel: "AnswersChannel", question_id: questionId } ,  {
    connected: ->
      console.log 'Connected to channel: ' + channel
      @perform 'follow'
    ,

    received: (data) ->
      console.log data
      questionsList.append data

  })

$(document).on('turbolinks:load', answer_func);