comments_func = ->

  $('comments').hide()
  $('.comment_form').hide()
  $('.row').on('click', '.comment_link', (e)->
    e.preventDefault()
    id = $(this).data('commentableId')
    type = $(this).data('commentableType')
    $("#form-#{type}-#{id}").show()
  );

  App.cable.subscriptions.create('CommentsChannel', {
    connected: ->
      console.log 'Connected to channel: comments'
      @perform 'follow'
    ,

    received: (data) ->
      object = $.parseJSON(data)
      $("#comments-list-#{object.commentable_type.toLowerCase()}-#{object.commentable_id}").append object.body
      $('.comment_form').hide()
      $('.comment_link').show()
      $('.comments').show()
  })

$(document).on('turbolinks:load', comments_func);
