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
      vex.dialog.alert
        message: $element
        vex.dialog.buttons.YES.text = 'Gotcha!'

    # Show submitted information in a modal
    $(".applied.done").on "click", ->
      showDialog $(this).next(".dialog").html()

    # Create a new application instance when "apply now" is clicked from postings index page
    $(".applied.todo").on "click", (event) ->

        # First, create the application
        $.ajax
          url: "#{$(this).data("uri")}.json"
          type: "POST"
          data:
            job_application:
              posting_id: $(this).data("posting-id")

          # Then, open a dialog window
          success: (response) =>
            vex.dialog.open
              input: response.html
              buttons: [
                $.extend({}, vex.dialog.buttons.NO,
                  className: "primary"
                  text: "Update application"
                  click: ($vexContent, event) ->
                    $vexContent.data().vex.value = "update"
                    vex.close $vexContent.data().vex.id
                    return
                )
                $.extend({}, vex.dialog.buttons.NO,
                  className: "secondary"
                  text: "Undo"
                  click: ($vexContent, event) ->
                    $vexContent.data().vex.value = "undo"
                    vex.close $vexContent.data().vex.id
                    return
                )
              ]
              callback: (value) ->
                if value is "undo"
                  console.log "Undo application"
                else
                  console.log "Save application"
                return

              error: (response) ->
                console.log "Error: ", response




        $("input[type=date]").datepicker {dateFormat: "yy-mm-dd"}

        $(this).replaceWith response.replacementHTML
        $(this).parents('section').removeClass('action-required')
          


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
    $(".dropdown button").click (event) ->
      $(this).parent().find("ul").slideToggle(400)
      $(this).expanderSwap()
      $sibling = $(this).parent().siblings(".dropdown").find("ul")
      if $sibling.is(":visible")
        $sibling.slideUp(400)
        $sibling.parent().find("button").expanderSwap()

    # Close drop-down when clicking outside the menu
    $(document).on "click", (event) ->
      if !$(event.target).closest(".dropdown").length
        if $(".dropdown ul").is(":visible")
          $(".dropdown ul").slideUp(400)
          $(".dropdown ul").parent().find("button").expanderSwap()

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
