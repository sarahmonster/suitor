$ ->
  $(document).on "page:change", ->
    
    # Use mmenu plugin for a slick mobile menu
    $("#mobile-menu").mmenu()

    # Function for tooltips
    $.fn.showTooltip = (element) ->
      this.data "title", this.attr("title")
      this.attr "title", ""
      this.closest(element).append("<div class=\"tooltip\">#{this.data('title')}</div>");
      this.closest(element).css("position", "relative")
    $.fn.hideTooltip = (element) ->
      this.attr "title", this.data("title")
      this.closest(element).find('.tooltip').remove()

    # Make some custom tooltips happen (for form elements only, at least right now)
    $('label').mouseover ->
      if $(this).attr("title") 
        $(this).showTooltip("div")
    .mouseout ->
      $(this).hideTooltip("div")

    # Make sure they happen for input fields, too
    $('input').mouseover ->
      if $(this).parent().find('label').attr("title")
        $(this).parent().find('label').showTooltip("div")
    .mouseout ->
      $(this).parent().find('label').hideTooltip("div")

    # Let's try span elements now, too
    $('span').mouseover ->
      if $(this).attr("title")
        $(this).showTooltip("section")
    .mouseout ->
      $(this).hideTooltip("section")



