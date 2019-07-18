// $(function).on("turbolinks:load", function() {
//   // ターゲットにするオブジェクトを変数で定義
//   var 

//   // 新規投稿画像を一時保管する配列
//   var tempPhotos = [];

//   // DBに反映する際に送る配列
//   var newPhotos = [];

//   $()on('change', 'input[type="file"]', function(e){
    
//   })


//   // 画像の削除機能
// }); /* ("turbolinks:load", function() { */
$(document).on('turbolinks:load', function() { 
  $(function(){
    $('#photo_upload').change(function(e){
      //ファイルオブジェクトを取得する
      var file = e.target.files[0];
      var reader = new FileReader();
      console.log(file);
      console.log(reader);

      //アップロードした画像を設定する
      reader.onload = (function(file){
        return function(e){
          $("#img1").attr("src", e.target.result);
          $("#img1").attr("title", file.name);
        };
      })(file);
      reader.readAsDataURL(file);
    });
  });
});
