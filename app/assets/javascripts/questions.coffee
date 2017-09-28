question_func = ->
  questionsList = $(".questions-list")

  $('.edit-question-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    $('form#edit-question').show();

  

  App.cable.subscriptions.create('QuestionsChannel', {
    connected: ->
      console.log 'Connected to channel: questions'
      @perform 'follow'
    ,

    received: (data) ->
      console.log data
      questionsList.append data

  })

$(document).on('turbolinks:load', question_func);