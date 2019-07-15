$(document).on('turbolinks:load', function() { 
  $(function(){
    var uploadedPhotosLength = "";
    //画面がリロードされた時に商品に紐付く写真の枚数を数える
    var count_images = $('.image-box').length;
    if (count_images == 10){//写真が10枚の時はファイルフィールドを隠す
      $('.listing-upload__drag-box').hide();
    } 
    //写真の削除ボタンが押された時
    $('.listing-upload__wrapper').on('click', '.image-box__bottom--delete', function(){
      //削除ボタンの押された写真の表示を消す
      $(this).parents('.image-box').hide();
      count_images = $('.image-box:visible').length;
      //表示されている写真の合計枚数を数え、ファイルフィールドを復活させる
      if (count_images < 10){
        $('.listing-upload__drag-box').show();
      }
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
      $('#editForm').submit();
    });
  });
});