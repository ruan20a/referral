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
    $("#invited-users").removeClass "active in"
  });

  $("a[href=\"#invited-users\"]").click(function(){
    $("#active-users").removeClass "active in"
    $("#invited-referrals").addClass "active in"
  });
});
