# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

question_func = ->
  $('.edit-question-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    $('form#edit-question').show();

  $('.question_vote_up, .question_vote_down').on 'ajax:success', (e, data, status, xhr) ->
    question = $.parseJSON(xhr.responseText)
    votable_id = $(this).data('votableId')
    type = $(this).data('votableType')
    $(".#{question.id}_vote_rating").html(question.rating)
    $("#votable_" + type + "_" + votable_id + " .cancel_vote").show()

  .bind 'ajax:error', (e, xhr, status, error) ->
    $('.question_vote_errors').html(xhr.responseText)

  $('.cancel_vote').on 'ajax:success', (e, data, status, xhr) ->
    question = $.parseJSON(xhr.responseText)
    votable_id = $(this).data('votableId')
    type = $(this).data('votableType')
    $(".#{question.id}_vote_rating").html(question.rating)
    $("#votable_" + type + "_" + votable_id + " .cancel_vote").hide()

$(document).on('ready', question_func);
$(document).on('turbolinks:load', question_func);



  