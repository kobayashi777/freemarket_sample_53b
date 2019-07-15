$(document).on('turbolinks:load', function() { 
  $(function(){
    function buildImgHtml(image){
      var img = `<img src='${image}' class='image-box__top--image' width='114' height='114'>`
      return img
    }
    function buildRotateImgHtml(image){
      var img = `<img src='${image}' class='image-box__top--image' width='114' height='114' style="transform: rotate(90deg);">`
      return img
    }
    function appendImageBox(insertImg){
      var html =
      `<div class='image-box-new'>
        <div class='image-box__top'>
          ${insertImg}
        </div>
        <div class='image-box_bottom'>
        </div>
      </div>`
      $('.listing-upload__drag-box').before(html);
    }
    $('#photo_upload').change(function(e){
      e.preventDefault();
      var files = e.target.files;
      var count_images = $('.image-box:visible').length;
      if (count_images+files.length > 10){
        var errorHtml = 
        `<ul id='upload-error'>
          <li class= 'has_error_text'>画像は合計1枚以上10枚以下で選択してください</li>
        </ul>`
        $('#upload-error').remove();
        $('.listing-upload').append(errorHtml);
        $('html,body').scrollTop(0);
        $('#photo_upload').val("");
      } else {
        $('.image-box-new').remove();
        $.each(files, function(index, file){
          EXIF.getData(file, function() {
            var orientation = "";
            orientation = EXIF.getTag(this, "Orientation")
            var fileReader = new FileReader();
            fileReader.onload = function(e) {
              var loadedImageUri = e.target.result;
              if ( orientation == 6 ){
                insertImg = buildRotateImgHtml(loadedImageUri);
              } else {
                insertImg = buildImgHtml(loadedImageUri);
              }
              appendImageBox(insertImg);
            };
            fileReader.readAsDataURL(file);
          })
        })
        if (count_images + files.length == 10){//写真が10枚の時はファイルフィールドを隠す
          $('.listing-upload__drag-box').hide();
        }
      }
    })
    $('#product-send-btn').on('click', function(e){
      e.preventDefault();
      $('#productForm').submit();
    })
    $('.preview-reset').on('click', function(){
      $('.image-box-new').remove();
      $('#photo_upload').val("");
      $('.listing-upload__drag-box').show();
    })
  })
})
