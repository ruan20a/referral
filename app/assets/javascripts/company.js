$(document).ready(function(){
  $(".company").click(function(){
    window.location = this.getAttribute("data-companyurl");
  });
  // figure out max height
  // function thisHeight(){
  //   return $(this).height();
  // }

  // var heights = $("div.equal-height").map(function() {
  //       return $(this).height();
  // }).get(),
  // maxHeight = Math.max.apply(null, heights);
  // $(".company").each(function () {
  //   $(this).height(maxHeight)
  //   $(this).text(maxHeight)
  // });
  var heights = $("div.equal-height").map(function ()
    {
        return $(this).height();
    }).get(),
  maxHeight = Math.max.apply(null, heights);
  $("div.equal-height").css("height", maxHeight);

// // var highest = null;
// // var hi = 0;
// // $(".panel").each(function(){
// //   var h = $(this).height();
// //   if(h > hi){
// //      hi = h;
// //      highest = $(this);
// //   }
// // });
// // //highest now contains the div with the highest so lets highlight it
// // highest.css("background-color", "red");


  $("a[href=\"#active-users\"]").click(function() {
    if($("#invited-users").hasClass("active in")) {
      $("#invited-users").removeClass("active in")
    }
  });

  $("a[href=\"#invited-users\"]").click(function(){
    $("#active-users").removeClass("active in")
    $("#invited-users").addClass("active in")
  });

});





  function addPrivateInvitation(){
    var newEmail = $("#new-email").val();
    var newFN = $("#new-first-name").val();
    var newLN = $("#new-last-name").val();
    var newInvite = {private_invitations: {email: newEmail, first_name: newFN, last_name: newLN}};
    $.ajax({
      type: "POST",
      url: "/company/:id/private_invitations",
      data: newInvite,
      dataType: "json"
    }).done(function(response) {
      $('#myModal').modal('hide');
      location.reload();
      //isotope addItem to page
      // call an isotope thing that updates the page
      // where the response appends to the body of the site.
    });
  };
