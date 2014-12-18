class @GoogleAnalytics

  @load: ->
    # Set up data to send to GA
    #ga = ''
    #ga('create', GoogleAnalytics.analyticsID(), 'auto');
    #ga('send', 'pageview');
    #ga('set', '&uid', GoogleAnalytics.userID());

    # Create a script element and insert it in the DOM
    gc = document.createElement("script")
    balderdash = "(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');"
    gc.async = true
    gc.src = ((if "https:" is document.location.protocol then "https://ssl" else "http://www")) + ".google-analytics.com/analytics.js"
    firstScript = document.getElementsByTagName("script")[0]
    #firstScript.parentNode.insertBefore gc, balderdash
    firstScript.parentNode.insertBefore gc, firstScript


    # If Turbolinks is supported, set up a callback to track pageviews on page:change.
    # If it isn't supported, just track the pageview now.
    if typeof Turbolinks isnt 'undefined' and Turbolinks.supported
      document.addEventListener "page:change", (->
        GoogleAnalytics.trackPageview()
      ), true
    else
      GoogleAnalytics.trackPageview()

  @trackPageview: (url) ->
    unless GoogleAnalytics.isLocalRequest()
      if url
        window._gaq.push ["_trackPageview", url]
      else
        window._gaq.push ["_trackPageview"]
      window._gaq.push ["_trackPageLoadTime"]

  @isLocalRequest: ->
    GoogleAnalytics.documentDomainIncludes "local"

  @documentDomainIncludes: (str) ->
    document.domain.indexOf(str) isnt -1

  @analyticsID: ->
    'UA-975356-6'

  @userID: ->
    'xxx'

console.log GoogleAnalytics.load()

GoogleAnalytics.load()

