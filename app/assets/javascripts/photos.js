$(document).on('turbolinks:load', function() { 
  $(function(){
    // 画像向きをそのままでimgタグ作成
    function buildImgHtml(image){
      var img = `<img src='${image}' class='image-box__top--image' width='114' height='114'>`
      return img
    }
    // 画像向きを90度回転させてimgタグ作成
    function buildRotateImgHtml(image){
      var img = `<img src='${image}' class='image-box__top--image' width='114' height='114' style="transform: rotate(90deg);">`
      return img
    }
    // プレビュー用のhtml作成
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
    // file_fieldに画像がアップロードされた時
    $('#photo_upload').change(function(e){
      e.preventDefault();
      var files = e.target.files; // アップロードされたファイルを取得
      var count_images = $('.image-box:visible').length; // 初期で表示されている画像の枚数をカウント
      if (count_images+files.length > 10){ // 初期で表示されている画像とアップロードされた画像の枚数が10枚を超える場合
        // エラー表示
        var errorHtml = 
        `<ul id='upload-error'>
          <li class= 'has_error_text'>画像は合計1枚以上10枚以下で選択してください</li>
        </ul>`
        $('#upload-error').remove();
        $('.listing-upload').append(errorHtml);
        $('html,body').scrollTop(0); // ページトップへスクロール
        $('#photo_upload').val(""); // アップロードされた中身をリセット
      } else {
        $('.image-box-new').remove(); // 元々アップロードされた画像のプレビューを削除
        $.each(files, function(index, file){
          // アップロードされた画像を１つづつ取り出し、画像のorientationを取得
          EXIF.getData(file, function() {
            var orientation = "";
            orientation = EXIF.getTag(this, "Orientation")
            var fileReader = new FileReader();
            fileReader.onload = function(e) {
              var loadedImageUri = e.target.result; // 画像のURIを取得
              if ( orientation == 6 ){ //縦画像の場合
                insertImg = buildRotateImgHtml(loadedImageUri);
              } else { // 横画像の場合
                insertImg = buildImgHtml(loadedImageUri);
              }
              appendImageBox(insertImg);
            };
            fileReader.readAsDataURL(file);
          })
        })
        // 初期で表示されている画像とアップロードされた画像の枚数が10枚の場合
        if (count_images + files.length == 10){
          $('.listing-upload__drag-box').hide(); // アップロードフィールドを隠す
        }
      }
    })
    $('#product-send-btn').on('click', function(e){
      e.preventDefault();
      $('#productForm').submit();
    })
    // リセットプレビューが押された時
    $('.preview-reset').on('click', function(){
      $('.image-box-new').remove(); // プレビューをリセット
      $('#photo_upload').val(""); // アップロードされた中身をリセット
      if ($('.image-box:visible').length != 10){ // 初期で表示中の画像枚数が10枚でない時
        $('.listing-upload__drag-box').show(); // アップロードフィールドを表示する
      }
    })
  })
})
