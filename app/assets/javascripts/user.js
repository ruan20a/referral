$(document).ready(function() {
  $("a[href=\"#received-referrals\"]").on("click", function() {
    if ($("div#received-referrals").hasClass("active in")){
      alert(haha)
      $("div#ask-referrals").removeClass("active in");
      $("div#sent-referrals").removeClass("active in");
    }
    else {
      $("div#received-referrals").addClass("active in")
    }
  });

  $("a[href=\"#sent-referrals\"]").on("click", function() {
    if ($("div#received-referrals").hasClass("active in")){
      $("div#received-referrals").removeClass("active in");
    }
    if ($("div#ask-referrals").hasClass("active in")){
      $("div#ask-referrals").removeClass("active in");
    }
    $("#sent-referrals").addClass("active in");
  });
  $("a[href=\"#ask-referrals\"]").on("click", function() {
    if ($("div#received-referrals").hasClass("active in")){
      $("div#received-referrals").removeClass("active in");
    }
    if ($("div#sent-referrals").hasClass("active in")){
      $("div#sent-referrals").removeClass("active in");
    }
    $("div#ask-referrals").toggleClass("active in");
  });

  // $("#received-referrals").infinitescroll({
  //   navSelector: "nav.pagination",
  //   nextSelector: "nav.pagination a[rel=next]",
  //   itemSelector: "#received-referrals tr.received"
  // });
});