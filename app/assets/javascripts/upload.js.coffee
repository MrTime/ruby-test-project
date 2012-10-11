log = (html) ->
  document.getElementById("log").innerHTML = html
onSuccess = ->
  log "success"
onError = ->
  log "error"
onProgress = (loaded, total) ->
  log loaded + " / " + total

form = document.forms.upload
form.onsubmit = ->
  file = @elements.photo.files[0]
  upload file, onSuccess, onError, onProgress  if file
  false
  
upload = (file, onSuccess, onError, onProgress) ->
  xhr = new XMLHttpRequest()
  xhr.onload = xhr.onerror = ->
    unless @status is 200
      onError this
      return
    onSuccess()

  xhr.upload.onprogress = (event) ->
    onProgress event.loaded, event.total

  xhr.open "POST", "/photos/add", true
  formData = new FormData()
  formData.append "photo", file
  xhr.send formData
