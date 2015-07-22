$(document).ready(function() {
  return $("#home_feed .page").infinitescroll({
    navSelector: "nav.pagination",
    nextSelector: "nav.pagination a[rel=next]",
    itemSelector: "#home_feed div.hello"
  });
});
