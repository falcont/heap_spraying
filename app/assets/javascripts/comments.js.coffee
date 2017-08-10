comments_func = ->
  $('.comment_form').hide()
  $('.comment_link').click (e) ->
    $(this).hide();
    e.preventDefault();
    $('.comment_form').show();

$(document).on('ready', comments_func);
$(document).on('turbolinks:load', comments_func);

