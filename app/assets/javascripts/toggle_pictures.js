$(document).ready(function(){

  var clearIntervalXYZ;

  $('button.proper_size').mouseenter(function(){
    var arrayPhotoIds = $(this).
                                parents('[data-img-list]').
                                attr('data-img-list').
                                split(",");

    var divisor = arrayPhotoIds.length
    var currentPhotoNumber = 0
    $(this).
            find("#" + arrayPhotoIds[currentPhotoNumber % divisor]).
            attr('style', 'opacity:0')
    $(this).
            find("#" + arrayPhotoIds[(currentPhotoNumber + 1) % divisor]).
            attr('style', 'opacity:1')
    currentPhotoNumber += 1
    clearIntervalXYZ = setInterval(function(){
      $(this).
              find("#" + arrayPhotoIds[currentPhotoNumber % divisor]).
              attr('style', 'opacity:0')
      $(this).
              find("#" + arrayPhotoIds[(currentPhotoNumber + 1) % divisor]).
              attr('style', 'opacity:1')
      currentPhotoNumber += 1
    }.bind(this),1350);
  });

  $('button.proper_size').mouseleave(function(){
    var arrayPhotoIds = $(this).
                                parents('[data-img-list]').
                                attr('data-img-list').
                                split(",");

    arrayPhotoIds.forEach(function(photoId, i){
      if (i == 0) {
        $('#' + photoId).attr('style', 'opacity:1')
      } else {
        $('#' + photoId).attr('style', 'opacity:0')
      }
    });
    clearInterval(clearIntervalXYZ)
  });

  $('button.proper_size').each(function(_,e){
    var arrayPhotoIds = $(this).
                                parents('[data-img-list]').
                                attr('data-img-list').
                                split(",")

    arrayPhotoIds.forEach(function(photoId, i){
      if (i == 0) {
        $('#' + photoId).attr('style', 'opacity:1')
      } else {
        $('#' + photoId).attr('style', 'opacity:0')
      }
    });
  });
});
