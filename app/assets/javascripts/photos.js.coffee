$ ->
  $("#clickMe").click ->
    $("#uploadMe").click()

  $("#uploadMe").on "change", ->
    $("#new_photo").submit()
