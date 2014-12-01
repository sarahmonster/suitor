$ ->
  $(document).on "page:change", ->
    $('a[data-method="delete"]:not(.logout)').on "click", (e) ->
      $link = $(this)

      vex.dialog.open
        message: "Are you sure you want to delete this? No changing your mind!"
        buttons: [
          $.extend({}, vex.dialog.buttons.NO,
            className: "secondary"
            text: "Cancel"
            click: ($vexContent, event) =>
              $vexContent.data().vex.value = "cancel"
              vex.close $vexContent.data().vex.id
          )
          $.extend({}, vex.dialog.buttons.YES,
            className: "primary"
            text: "Delete"
            click: ($vexContent, event) =>
              $vexContent.data().vex.value = "confirm"
              $.rails.handleMethod($link)

              # This prevents the box from going away and then appearing again.
              event.preventDefault()
          )
        ]

      e.preventDefault()

    $.rails.confirm = (message) ->
      return false
