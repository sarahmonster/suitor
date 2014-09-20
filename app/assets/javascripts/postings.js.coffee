# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on "page:change", ->

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

    $("input").focus ->
      $(this).parent().addClass "focus"
      return

    $("input").blur ->
      $(this).parent().removeClass "focus"
      return

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

    # Fade out posting listing when archived     
    $(".archive-toggle").on "ajax:complete", ->
      $(this).fadeOut(100).fadeIn(300)
      if $(this).find("span").text() is "Unarchive"
        $(this).find("span").text "Archive"
      else
        $(this).find("span").text "Unarchive"
      $("##{$(this).data('id')}").fadeOut 500, =>
        $("##{$(this).data('id')}").remove()

    # Show application data on click
    $(".expander").on "click", (event) ->
      $(this).next(".expand-panel").slideToggle(800, 'easeInOutBounce')
      if $(this).find(".expander-icon").hasClass('icon-arrow-down9')
        $(this).find(".expander-icon").switchClass('icon-arrow-down9', 'icon-arrow-up8')
      else
        $(this).find(".expander-icon").switchClass('icon-arrow-up8', 'icon-arrow-down9')
