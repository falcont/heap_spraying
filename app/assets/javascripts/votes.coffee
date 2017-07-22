votes_func = ->

  $('.vote_up, .vote_down').on 'ajax:success', (e, data, status, xhr) ->
    object = $.parseJSON(xhr.responseText)
    votable_id = $(this).data('votableId')
    type = $(this).data('votableType')
    $(".#{object.id}_vote_rating").html(object.rating)
    $("#votable_" + type + "_" + votable_id + " .cancel_vote").show()

  $('.cancel_vote').on 'ajax:success', (e, data, status, xhr) ->
    object = $.parseJSON(xhr.responseText)
    votable_id = $(this).data('votableId')
    type = $(this).data('votableType')
    $(".#{object.id}_vote_rating").html(object.rating)
    $("#votable_" + type + "_" + votable_id + " .cancel_vote").hide()

$(document).on('ready', votes_func);
$(document).on('turbolinks:load', votes_func);