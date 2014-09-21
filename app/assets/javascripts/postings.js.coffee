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

    # Create a new application instance when "apply now" is clicked from postings index page
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
          $(this).parents('section').removeClass('action-required')
          $(".edit_job_application").on "ajax:success", ->
            $dialog.dialog "destroy"
        error: (response) ->
          console.log "Error: ", response


    # Mark application as followed-up when "follow up" is clicked (from index or detail page)
    $(".followup.todo").on "click", (event) ->
      $.ajax
        url: "#{$(this).data("uri")}.json"
        type: "PUT"
        success: (response) =>
          $(this).find("span").text "Good work!"
          $(this).switchClass('todo', 'done')
          $(this).switchClass('icon-circle-blank', 'icon-checkmark')
          $(this).parents('section').removeClass('action-required')
        error: (response) ->
          console.log "Error: ", response

    
    # Swap down arrow for up
    $.fn.expanderSwap = ->
      if this.find(".expand-icon").hasClass('icon-arrow-down9')
        this.find(".expand-icon").switchClass('icon-arrow-down9', 'icon-arrow-up8')
      else
        this.find(".expand-icon").switchClass('icon-arrow-up8', 'icon-arrow-down9')

    # Show drop-down filters
    $(".filter-buttons button").click (event) ->
      $(".filter-buttons ul").slideToggle(400)
      $(this).expanderSwap()

    # Close drop-down when clicking outside the menu
    $(document).on "click", (event) ->
      if !$(event.target).closest(".filter-buttons").length
        if $(".filter-buttons ul").is(":visible")
          $(".filter-buttons ul").slideUp(400)
          $(".filter-buttons button").expanderSwap()

    # Show and hide postings according to user's filter 
    $(".filter-buttons a").click (event) ->
      event.preventDefault()
      # Change appearance of button
      if $(this).find('li').hasClass('checked')
        $(this).find('li i').switchClass('icon-checkmark', 'icon-circle-blank')
      else 
        $(this).find('li i').switchClass('icon-circle-blank', 'icon-checkmark')
      $(this).find('li').toggleClass('checked')
      # Toggle postings of the given class
      buttonClass = $(this).data('class')
      $("section.#{buttonClass}").toggle(400)


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
      $(this).next(".expand-panel").slideToggle(400, 'easeInOutBounce')
      $(this).expanderSwap()
