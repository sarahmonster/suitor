$ ->
  $(document).on "page:change", ->
    
    # Use mmenu plugin for a slick mobile menu
    $("#mobile-menu").mmenu()

    # Make some custom tooltips happen (for form elements only, at least right now)
    $('label').mouseover(->
      if $(this).attr("title") 
        $(this).data "title", $(this).attr("title")
        $(this).attr "title", ""
        $(this).parent().append("<div class=\"tooltip\">#{$(this).data('title')}</div>");
        $(this).parent().css("position", "relative")
    ).mouseout ->
      $(this).attr "title", $(this).data("title")
      $(this).parent().find('.tooltip').remove()
