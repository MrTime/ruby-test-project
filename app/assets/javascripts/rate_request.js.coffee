loadDataFromServer = ->

  rating = this.id
  url = window.location.href

  req = new XMLHttpRequest()

  req.addEventListener 'readystatechange', ->
    if req.readyState is 4   
      if req.status is 200 or req.status is 304
        $("#button_rate").fadeOut 300
        $("#visible_rate").css "visibility", "visible"
        visible_rate = (html) -> 
          document.getElementById("visible_rate").innerHTML = html
        visible_rate  req.responseText  
      else
        console.log 'Error loading data...'
  
  book_id = (url.match /books\/\d+/)[0].match /\d+/ 
  alert book_id
  req.open('GET', '/books/rate/' + rating  + "?book_id=" + book_id, true)
  req.send()

$(".btn").click loadDataFromServer
