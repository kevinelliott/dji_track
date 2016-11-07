$(document).on 'ready page:change', ->

  $('body').on('click', '[data-toggle="modal"]', ->
    $($(this).data('target')+' .modal-title').html('Change History for ' + $(this).data('maskedOrderId'))
    $($(this).data('target')+' .modal-body').load($(this).data("remote"))
  )
