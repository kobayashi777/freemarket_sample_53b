$(document).on('turbolinks:load', function() { 
  $(function(){
    var uploadedPhotosLength = "";
    //画面がリロードされた時に商品に紐付く写真の枚数を数える
    var count_images = $('.image-box').length;
    if (count_images == 10){//写真が10枚の時はファイルフィールドを隠す
      $('.listing-upload__drag-box').hide();
    } 
    //写真の削除ボタンが押された時
    $('.image-box__bottom--delete').on('click', function(){
      //削除ボタンの押された写真の表示を消す
      $(this).parents('.image-box').hide();
      count_images = $('.image-box:visible').length;
      //表示されている写真の合計枚数を数え、ファイルフィールドを復活させる
      if (count_images < 10){
        $('.listing-upload__drag-box').show();
      }
    });
    //アップロードされた写真の枚数を数える
    $('#photo_upload').change(function(e){
      uploadedPhotosLength = e.target.files.length;
    });
    //送信ボタンが押された時、一度submitを止め、データの成形と写真に対するバリデーションを行う
    $('#edit-send-btn').on('click', function(e){
      e.preventDefault();
      //削除ボタンが押された写真のidを取得する
      var deletePhotoIds = [];
      $('.image-box:hidden').each(function(index, photo){
        deletePhotoIds.push($(photo).data('photo'));
      });
      //削除ボタンの押された写真のidの配列をparamsに追加する
      $("#delete-photos").append(
        $('<input type="hidden" name="delete_photos">').val(deletePhotoIds)
      ); 
      //初期の写真のidを取得する
      var initialPhotoIds = [];
      $('.image-box').each(function(index, photo){
        initialPhotoIds.push($(photo).data('photo'));
      });
      //画面に表示されている写真とアップロードされた写真の枚数の合計を数える
      var sumPhotos = initialPhotoIds.length - deletePhotoIds.length + uploadedPhotosLength;
      //合計写真枚数が1枚以上10枚以下を確認しバリデーション
      if (1 <= sumPhotos && sumPhotos <= 10) {
        $('#editForm').submit();
      } else {
        var errorHtml = `<ul id= 'upload-error'>
                          <li class= 'has_error_text'>画像は合計1枚以上10枚以下で選択してください</li>
                         </ul>`
        $('#upload-error').remove();
        $('.listing-upload').append(errorHtml);
      }
    });
    $('#product-send-btn').on('click', function(e){
      e.preventDefault();
      $('#productForm').submit();
    })
  });
});