$(function(){
  $(".project_update_doc").click(function(){
    var project_id = $(this).attr("data-project-id");
    $.ajax({
      type: "POST",
      url: "/projects/update_doc/" + project_id,
      dataType: "json",
      success: function(response){
        var alert = $("<div/>").addClass("alert alert-success alert-dismissible").attr("role", "alert");

        var button = $("<button/>").addClass("close").attr("data-dismiss", "alert");
        $("<span/>").attr("aria-hidden", "true").html("&times;").appendTo(button);
        $("<span/>").addClass("sr-only").text("Close").appendTo(button);
        button.appendTo(alert);

        $("<span/>").text(response.message).appendTo(alert);

        alert.appendTo($("#alert-area"));
      }
    });
  });
});
