$ ->
  # Check to see if users device supports getUserMedia
  navigator.getUserMedia = navigator.getUserMedia or navigator.webkitGetUserMedia or navigator.mozGetUserMedia or navigator.msGetUserMedia

  # Variables
  video = document.querySelector('video')
  canvas = document.querySelector('canvas')
  ctx = canvas.getContext('2d')
  localMediaStream = null

  errorCallback = (e) ->
    alert 'Uh oh, something went wrong, please try again.'
    console.log e

  snapshot = ->
    if !localMediaStream
      ctx.drawImage video, 0, 0
      image_string = canvas.toDataURL('image/png')

      # Ajax call to upload image string
      if window.roll_id?
        $.ajax
          type: 'POST'
          url: "/rolls/#{window.roll_id}/photos.json"
          dataType: 'json'
          data: {photo: {base_64_photo: image_string}}
          success: (data) ->
            $('#available_photos').text(data.available_photos)
            toggleButtons()
            if data.available_photos < 1
              $('#roll_not_full').remove()
              $('#roll_full').show()
              $('#take_photo_webcam').show()

  toggleButtons = ->
    $('#take_photo_webcam').toggleClass('hidden')
    $('#take_photo_webcam_disabled').toggleClass('hidden')

  $('#take_photo_webcam').click ->
    $('#camera_shutter').trigger('play')
    toggleButtons()
    snapshot false

  if navigator.getUserMedia
    videoParams =
      audio: false
      video:
        mandatory:
          minWidth: 540,
          minHeight: 480

    createStream = (stream) ->
      $('#display_info').remove()
      $('#remaining_photos').fadeIn(1000).toggleClass('hidden')
      $('#display_video').fadeIn(1000)
      $('#take_photo_webcam').fadeIn(1000).toggleClass('hidden')
      video.src = window.URL.createObjectURL(stream)

    navigator.getUserMedia videoParams, createStream, errorCallback
  else
    $('#display_info').remove()
    $('#take_photo_webcam').remove()
    $('#take_photo').show()
    $('#remaining_photos').fadeIn(1000).toggleClass('hidden')
