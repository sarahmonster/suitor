# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'page:change', ->
    $('input[type=date]').datepicker {dateFormat: 'yy-mm-dd'}

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
