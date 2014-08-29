$(document).ready(function(){
  $(".company").click(function(){
    window.location = this.getAttribute("data-companyurl");
  });
  // figure out max height
  var heights = $(".company").map(function() {
        return $(this).height();
  }).get(),
  maxHeight = Math.max.apply(null, heights);
  $(".company").height(maxHeight);


  $("a[href=\"#active-users\"]").click(function(){
    if $("invited-users").class == "active in"
      $("#invited-users").removeClass "active in"
    end
  });

  $("a[href=\"#invited-users\"]").click(function(){
    $("#active-users").removeClass "active in"
    $("#invited-users").addClass "active in"
  });

  $('#add-invite-button').click(function(){alert('aaa')});

    $(document).on("click", '#add-invite-button', function(){
    alert('aaaa')
  });

});

  $(document).on("click", '#add-invite-button', function(){
    alert('aaaa')
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
