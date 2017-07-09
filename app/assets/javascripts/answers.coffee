# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

answer_func = ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).show()
    
  $('.answer_vote_up, .answer_vote_down').on 'ajax:success', (e, data, status, xhr) ->
    answer = $.parseJSON(xhr.responseText)
    votable_id = $(this).data('votableId')
    type = $(this).data('votableType')
    $(".#{answer.id}_vote_rating").html(answer.rating)
    $(".votable_" + type + "_" + votable_id + ".cancel_vote").show()

  .bind 'ajax:error', (e, xhr, status, error) ->
    answer = $.parseJSON(xhr.responseText)
    $(".#{answer.id}_vote_errors").html("<div class='alert alert-danger alert-dismissable fade in'><a href='#' class='close' data-dismiss='alert' aria-label='close'>×</a><strong>You can't vote twice!</strong></div>").fadeOut(3000);

  $(".cancel_vote").on 'ajax:success', (e, data, status, xhr) ->
    answer = $.parseJSON(xhr.responseText)
    votable_id = $(this).data('votableId')
    type = $(this).data('votableType')
    $(".#{answer.id}_vote_rating").html(answer.rating)
    $("#votable_" + type + "_" + votable_id + ".cancel_vote").hide()

$(document).on('ready', answer_func);
$(document).on('turbolinks:load', answer_func);
