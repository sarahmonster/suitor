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

    
    # Drop-down filters
    $(".filter-buttons button").click (event) ->
      $(".filter-buttons ul").slideToggle(400)

    # Show and hide postings according to user's filter 
    $(".filter-buttons a").click (event) ->
      event.preventDefault()
      if $(this).find('li').hasClass('checked')
        $(this).find('li i').switchClass('icon-checkmark', 'icon-circle-blank')
      else 
        $(this).find('li i').switchClass('icon-circle-blank', 'icon-checkmark')
      $(this).find('li').toggleClass('checked')
      buttonClass = $(this).data('class')
      $("section.#{buttonClass}").toggle(400)


    # Fade out posting listing when archived     
    $(".archive-toggle").on "ajax:complete", ->
      $("##{$(this).data('id')}").fadeOut 500, =>
        $("##{$(this).data('id')}").remove()
