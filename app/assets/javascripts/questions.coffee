# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

question_func = ->
  $('.edit-question-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    $('form#edit-question').show();

  $('.vote_up').on 'ajax:success', (e, data, status, xhr) ->
    $('.vote_rating').html(xhr.responseText)
    console.log(xhr.responseText)

  $('.vote_down').on 'ajax:success', (e, data, status, xhr) ->
    $('.vote_rating').html(xhr.responseText)
    console.log(xhr.responseText)

$(document).on('ready', question_func);
$(document).on('turbolinks:load', question_func);