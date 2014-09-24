$(document).ready ->
  $("a[href=\"#received-referrals\"]").on "click", ->
    $("#sent-referrals").addClass "active in" .removeClass "active in"
    $("#ask-referrals").addClass "active in" .removeClass "active in"
    return

  $("a[href=\"#sent-referrals\"]").on "click", ->
    $("#received-referrals").addClass "active in".removeClass "active in"
    $("#ask-referrals").addClass "active in".removeClass "active in"
    $("#sent-referrals").removeClass "active in".addClass "active in"
    return

  $("a[href=\"#ask-referrals\"]").on "click", ->
    $("#sent-referrals").addClass "active in".removeClass "active in"
    $("#received-referrals").addClass "active in".removeClass "active in"
    $("#ask-referrals").removeClass "active in".addClass "active in"
    return

  $("#received-referrals").infinitescroll
    navSelector: "nav.pagination" # selector for the paged navigation (it will be hidden)
    nextSelector: "nav.pagination a[rel=next]" # selector for the NEXT link (to page 2)
    itemSelector: "#received-referrals tr.received"