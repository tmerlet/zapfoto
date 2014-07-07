$ ->
  # When take_photo is clicked, upload_photo is clicked also
  console.log "HERE!"

  $("#take_photo").click ->
    $("#upload_photo").click()
  # Form is submitted when upload_photo value changes
  $("#upload_photo").on "change", ->
    $("#new_photo").submit()
