comments_func = ->

  $('.comment_form').hide();
  $('#commentable_question.comment_link ').click (e) ->
    e.preventDefault()
    $(this).hide()
    $('#commentable_question.comment_form').show()

  $('#commentable_answer.comment_link ').click (e) ->
    e.preventDefault()
    $(this).hide()
    $('#commentable_answer.comment_form').show()


  $('.comment_form').on 'ajax:success', (e, data, status, xhr) ->
    comment = $.parseJSON(xhr.responseText)
    #object = $.parseJSON(xhr.responseText)
    type = $(this).data('commentableType')
    console.log(type)
    console.log(comment)
    $("#commentable_" + "#{type}" + "_" + ".comments_list").append(comment.body)
    $('.comment_form').hide()
    $('.comment_link').show()

$(document).on('ready', comments_func);
$(document).on('turbolinks:load', comments_func);
