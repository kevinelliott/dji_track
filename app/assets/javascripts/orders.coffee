$(document).on 'ready turbolinks:load', ->

  $('body').on('click', '[data-toggle="modal"]', ->
    $($(this).data('target')+' .modal-body').load($(this).data("remote"))
    $($(this).data('target')+' .modal-title').html('Change History for ' + $(this).data('maskedOrderId'))
  )
