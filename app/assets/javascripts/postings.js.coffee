# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on "page:change", ->
    $("input[type=date]").datepicker {dateFormat: "yy-mm-dd"}

    showDialog = ($element) ->
      dialog = $element.dialog
        modal: true
        width: "auto"

        close: ->
          dialog.dialog "destroy"

        show:
          effect: "fade"
          duration: 800

        hide:
          effect: "fade"
          duration: 200

    # Show submitted information in a modal
    $(".applied.done").on "click", ->
      showDialog $(this).next(".dialog")

    # Listen to all the "Apply Now" links on the postings index view.
    $(".applied.todo").on "click", (event) ->
      $.ajax
        url: "#{$(this).data("uri")}.json"
        type: "POST"
        data:
          job_application:
            posting_id: $(this).data("posting-id")
        success: (response) =>
          $(this).next(".dialog").replaceWith(response.html)
          $dialog = showDialog $(this).next(".dialog")

          $(this).replaceWith response.replacementHTML

          $(".edit_job_application").on "ajax:success", ->
            $dialog.dialog "destroy"
        error: ->
          # TODO: Add an error message.
          console.log "fail"
