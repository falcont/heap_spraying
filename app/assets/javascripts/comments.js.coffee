comments_func = ->
  $('.comment_form').hide();
  $('.comment_link').click (e) ->
    e.preventDefault()
    $(this).hide()
    $('.comment_form').show()

  $('.comment_form').on 'ajax:success', (e, data, status, xhr) ->
    comment = $.parseJSON(xhr.responseText)
    $('.comments_list').append(comment.body)
    $('.comment_form').hide()
    $('.comment_link').show()

$(document).on('ready', comments_func);
$(document).on('turbolinks:load', comments_func);

