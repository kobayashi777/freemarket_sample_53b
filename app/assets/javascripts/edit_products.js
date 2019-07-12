$(document).on('turbolinks:load', function() { 
  $(function(){
    var count_images = $('.image-box').length
    if (count_images == 10){
      $('.listing-upload__drag-box').hide();
    } 
    $('.image-box__bottom--delete').on('click', function(){
      $(this).parents('.image-box').hide();
      count_images = $('.image-box:visible').length
      if (count_images < 10){
        $('.listing-upload__drag-box').show();
      }
    })
    $('.listing-product-submit-box__send-btn').on('click', function(e){
      e.preventDefault();
      deletePhotoIds = [];
      $('.image-box:hidden').each(function(index, photo){
        deletePhotoIds.push($(photo).data('photo'))
      })
      $("#delete-photos").append(
        $('<input type="hidden" name="delete_photos">').val(deletePhotoIds)
      ); 
      $('#productForm').submit();
    })
  })
});