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

    # Add focus classes to container divs when an input/textarea is focused on (used for styling)
    $("input").focus ->
      $(this).parent().addClass "focus"
      
    $("input").blur ->
      $(this).parent().removeClass "focus"

    $("textarea").focus ->
      $(this).parent().addClass "focus"

    $("textarea").blur ->
      $(this).parent().removeClass "focus"

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
    $('.status span').mouseover ->
      if $(this).attr("title")
        $(this).showTooltip("section")
    .mouseout ->
      $(this).hideTooltip("section")

    $('li span').mouseover ->
      if $(this).attr("title")
        $(this).showTooltip("li")
    .mouseout ->
      $(this).hideTooltip("li")

    # Pick a date across the site.
    $("input[type=date]").pickadate({
      format: "mmmm d",
      formatSubmit: "yyyy-mm-dd",
      hiddenName: true
    })
