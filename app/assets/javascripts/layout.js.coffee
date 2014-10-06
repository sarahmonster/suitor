$ ->
  $(document).on "page:change", ->
    
    # Use mmenu plugin for a slick mobile menu
    $("#mobile-menu").mmenu()

    # Function for tooltips
    $.fn.showTooltip = ->
      this.data "title", this.attr("title")
      this.attr "title", ""
      this.parent().append("<div class=\"tooltip\">#{this.data('title')}</div>");
      this.parent().css("position", "relative")
    $.fn.hideTooltip = ->
      this.attr "title", this.data("title")
      this.parent().find('.tooltip').remove()

    # Make some custom tooltips happen (for form elements only, at least right now)
    $('label').mouseover ->
      if $(this).attr("title") 
        $(this).showTooltip()
    .mouseout ->
      $(this).hideTooltip()



    # Make sure they happen for input fields, too
    $('input').mouseover ->
      if $(this).parent().find('label').attr("title")
        $(this).parent().find('label').showTooltip()
    .mouseout ->
      $(this).parent().find('label').hideTooltip()


