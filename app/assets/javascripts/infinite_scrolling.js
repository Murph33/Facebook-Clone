$(document).ready(function() {
  return $("#newsfeed .page").infinitescroll({
    navSelector: "nav.pagination",
    nextSelector: "nav.pagination a[rel=next]",
    itemSelector: "#newsfeed div.hello"
  });
});
