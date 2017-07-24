$ ->
  App.cable.subscriptions.create('QuestionsChannel', {
    connected: ->
      console.log 'Connected!'
      @perform 'do_something', text: 'hello'
    ,

    received: (data) ->
      console.log 'received', data
  })
