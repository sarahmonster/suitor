# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on "page:change", ->
    eleGroup = document.querySelectorAll("input[type=date]")
    for x of eleGroup
      new Pikaday(field: eleGroup[x])  if eleGroup.hasOwnProperty(x)

    $("textarea.wysiwyg").editable 
      inlineMode: false
      borderColor: "#dddddd"
      height: 500
      paragraphy: true
      placeholder: ''
      buttons: [
        "bold"
        "italic"
        "formatBlock"
        "sep"
        "insertOrderedList"
        "insertUnorderedList"
        "createLink"
        "sep"
        "html"
        "sep"
        "undo"
        "redo"
      ]
      blockTags: [
        "p"
        "blockquote"
        "h1"
        "h2"
        "h3"
        "h4"
      ]

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

          $("input[type=date]").datepicker {dateFormat: "yy-mm-dd"}

          $(this).replaceWith response.replacementHTML

          $(".edit_job_application").on "ajax:success", ->
            $dialog.dialog "destroy"
        error: ->
          # TODO: Add an error message.
          console.log "fail"
