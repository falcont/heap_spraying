question_func = ->
  questionsList = $(".questions-list")

  $('.edit-question-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    $('form#edit-question').show();

  

  App.cable.subscriptions.create('QuestionsChannel', {
    connected: ->
      @perform 'follow'
    ,

    received: (data) ->
      questionsList.append data

  })

$(document).on('ready', question_func);
$(document).on('turbolinks:load', question_func);