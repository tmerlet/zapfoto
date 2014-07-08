$ ->
  # When take_photo is clicked, upload_photo is clicked also
  $("#take_photo").click ->
    $("#upload_photo").click()

  # Form is submitted when upload_photo value changes
  $("#upload_photo").on "change", ->
    $("#new_photo").submit()

  # jQuery File Upload
  # $("#new_photo").fileupload
  #   dataType: "json"
  #   add: (e, data) ->
  #     types = /(\.|\/)(jpe?g|png)$/i
  #     data.context = $(tmpl("template-upload", data.files[0]))
  #     $('#new_photo').append(data.context)
  #     data.submit()
  #   progress: (e, data) ->
  #     if data.context
  #       progress = parseInt(data.loaded / data.total * 100, 10)
  #       data.context.find('.bar').css('width', progress + '%')
