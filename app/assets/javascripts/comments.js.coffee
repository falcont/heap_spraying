comments_func = ->

  $('comments').hide()
  $('.comment_form').hide()
  $('.row').on('click', '.comment_link', (e)->
    e.preventDefault()
    id = $(this).data('commentableId')
    type = $(this).data('commentableType')
    $("#form-#{type}-#{id}").show()
  );


  commentableType = $('.comments').data('commentableType')
  commentableId = $('.comments').data('commentableId')

  channel = '/' + commentableType + '/' + commentableId + '/comments'  


  App.cable.subscriptions.create({ channel: 'CommentsChannel', question_id: commentableId },  {
    connected: ->
      console.log 'Connected to channel: ' + channel
      @perform 'follow'
    ,

    received: (data) ->
      console.log data
      object = $.parseJSON(data)
      $("#comments-list-#{object.commentable_type.toLowerCase()}-#{object.commentable_id}").append object.body
      $('.comment_form').hide()
      $('.comment_link').show()
      $('.comments').show()
  })

$(document).on('turbolinks:load', comments_func);
