$(document).ready(function() {
  $("a[href=\"#received-referrals\"]").on("click", function() {
    $("#sent-referrals").removeClass("active in");
    $("#ask-referrals").removeClass("active in");
  });
  $("a[href=\"#sent-referrals\"]").on("click", function() {
    $("#received-referrals").removeClass("active in");
    $("#ask-referrals").removeClass("active in");
    $("#sent-referrals").toggleClass("active in");
  });
  $("a[href=\"#ask-referrals\"]").on("click", function() {

    $("#received-referrals").removeClass("active in");
    $("#sent-referrals").removeClass("active in");

    // if ("#sent-referrals").hasClass("active in"){
    //   $("#sent-referrals").removeClass("active in");
    // }

    $("#ask-referrals").toggleClass("active in");
  });
  $("#received-referrals").infinitescroll({
    navSelector: "nav.pagination",
    nextSelector: "nav.pagination a[rel=next]",
    itemSelector: "#received-referrals tr.received"
  });
});