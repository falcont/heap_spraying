comments_func = ->

  $('comments').hide()
  $('.comment_form').hide()
  $('.row').on('click', '.comment_link', (e)->
    e.preventDefault()
    id = $(this).data('commentableId')
    type = $(this).data('commentableType')
    console.log(id)
    console.log(type)
    $("#form-#{type}-#{id}").show()
  );

  #$('.comment_form').on 'ajax:success', (e, data, status, xhr) ->
    #comment = $.parseJSON(xhr.responseText)
    #object = $.parseJSON(xhr.responseText)
    
    #console.log(data.commentable_type.toLowerCase())
    #console.log(comment)
    #$("#commentable_" + "#{comment.commentable_type.toLowerCase()}" + "_" + "#{comment.commentable_id}" + ".comments_list").append(comment.body)
    #$('.comment_form').hide()
    #$('.comment_link').show()


  App.cable.subscriptions.create('CommentsChannel', {
    connected: ->
      console.log 'Connected!'
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
