$ ->
  # Check to see if users device supports getUserMedia
  navigator.getUserMedia = navigator.getUserMedia or navigator.webkitGetUserMedia or navigator.mozGetUserMedia or navigator.msGetUserMedia
  # Variables
  video = document.querySelector("video")
  canvas = document.querySelector("canvas")
  ctx = canvas.getContext("2d")
  localMediaStream = null

  errorCallback = (e) ->
    console.log "Sorry Bruh Bruh", e

  snapshot = ->
    if !localMediaStream
      ctx.drawImage video, 0, 0
      image_string = canvas.toDataURL("image/png")

      # Ajax call to upload image string
      if window.roll_id?
        $.ajax
          type: 'POST'
          url: "/rolls/#{window.roll_id}/photos.json"
          dataType: 'json'
          data: {photo: {base_64_photo: image_string}}
          success:
            $.ajax
              type: 'GET'
              url: "/rolls/#{window.roll_id}/available_photos.json"
              success:
                (data) ->
                  $('#available_photos').text(data)
                  if data < 1
                    $('#roll_not_full').remove()
                    $('#roll_full').show() 

  $('#take_photo_webcam').click ->
    snapshot false

  if navigator.getUserMedia
    navigator.getUserMedia
      audio: false
      video:
        mandatory:
          minWidth: 540,
          minHeight: 480
    , ((stream) ->
      # $('#display_video').attr('style', 'display: block;')
      $('#display_video').fadeIn(1000)
      video.src = window.URL.createObjectURL(stream)
    ), errorCallback
  else
    $('#take_photo').attr('style', 'display: block;')
    $('#take_photo_webcam').attr('style', 'display: none;')
