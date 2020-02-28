$ ->
  el = document.getElementByClassName("table-sortable")
  if el != null
    sortable = Sortable.create(el,
      delay: 200,
      onUpdate: (evt) ->
        $.ajax
          url: 'events/' + $("#event_id").val() + '/sort'
          type: 'patch'
          data: { from: evt.oldIndex, to: evt.newIndex }
    )