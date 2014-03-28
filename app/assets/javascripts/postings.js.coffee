# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'page:change', ->
    $('input[type=date]').datepicker {dateFormat: 'yy-mm-dd'}

  # Show submitted information in a modal
  $('.applied ').on 'click', ->
    dialog = $(this).next(".dialog").dialog
      modal: true
      width: "auto"

      close: ->
        dialog.dialog 'destroy'

      show:
        effect: "fade"
        duration: 800

      hide:
        effect: "fade"
        duration: 200

  # Listen to all the "Apply Now" links on the postings index view.
  $('.applied.todo').on 'click', ->
    $.ajax
      url: "#{$(this).data('uri')}.json"
      type: "POST"
      data:
        job_application:
          posting_id: $(this).data("posting-id")
      success: (response) =>
        $(this).replaceWith '<i class="applied icon-checkmark done"><span>Applied</span></i>'
      error: ->
        console.log "fail"

