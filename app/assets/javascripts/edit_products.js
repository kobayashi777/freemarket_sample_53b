$(function(){
  var count_images = $('.image-box').length
  if (count_images == 10){
    $('.listing-upload__drag-box').hide();
  } 
  $('.listing-upload__wrapper').on('change', function(){
    count_images = $('.image-box').length
    if (count_images < 10){
      $('.listing-upload__drag-box').show();
    }
  })
  $('.image-box__bottom--delete').on('click', function(){
    $(this).parents('.image-box').hide();
  })
  $('.listing-product-submit-box__send-btn').on('click', function(e){
    e.preventDefault();
    deletePhotoIds = [];
    $('.image-box:hidden').each(function(index, photo){
      deletePhotoIds.push($(photo).data('photo'))
    })
    console.log(deletePhotoIds)
    $("#delete-photos").append(
      $('<input type="hidden" name="delete_photos">').val(deletePhotoIds)
    ); 
    $('#editForm').submit();
  })
})