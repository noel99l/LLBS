// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require cocoon
//= require moment
//= require moment/ja.js
//= require bootstrap-datetimepicker
//= require trix
//= require_tree .



var data = {'data-format': 'yyyy-MM-dd hh:mm:ss' };
$(function(){
    $('.datepicker').attr(data);
    $('.datepicker').datetimepicker();
});


function initMap(latlng) {
  var map = new google.maps.Map(document.getElementById('map'), {
    center: latlng,
    zoom: 17
  });

  var marker = new google.maps.Marker({
    position: latlng,
    map: map
  });
}

function getLatLng(address) {
  var geocoder = new google.maps.Geocoder();
 console.log(geocoder);
 console.log(address);
  geocoder.geocode({
    address: address
  }, function(results, status) {
     console.log(results);
     console.log(status);
    if (status == google.maps.GeocoderStatus.OK) {
      for (var i in results) {
        if (results[i].geometry) {
          var latlng = results[i].geometry.location;
          initMap(latlng)
        }
      }
    }
  });
}


// 商品新規登録時に、画像を選択した段階でプレビューが表示されるようにする
function previewFile() {
  var preview = document.getElementById('image_preview');//どこでプレビューするか指定。'img[name="preview"]'などにすればimg複数あっても指定できます。
  var file    = document.querySelector('input[type=file]').files[0];//'input[type=file]'で投稿されたファイル要素の0番目を参照します。input[type=file]にmutipleがなくてもこのコードになります。
  var reader  = new FileReader();

  reader.addEventListener("load", function () {
    preview.src = reader.result;//めちゃめちゃ長い文字列が引き渡されます。ユーザーのファイルパスに紐付かない画像情報だと思います。
  }, false);

  if (file) {
    reader.readAsDataURL(file);//ここでreaderのメソッドに引数としてfileを入れます。ここで、readerのaddEventListenerが発火します。
  }
}


$(document).on('turbolinks:load', function(){
  // オプションを指定してSkipprの実行
  $("#theTarget").skippr({
    // スライドショーの変化（"fade" or "slide"）
    transition : 'fade',
    // 変化にかかる時間（ミリ秒）
    speed : 1000,
    // easingの種類
    easing : 'easeOutQuart',
    // ナビゲーションの形（"block" or "bubble"）
    navType : 'bubble',
    // 子要素の種類（"div" or "img"）
    childrenElementType : 'div',
    // ナビゲーション矢印の表示（trueで表示）
    arrows : false,
    // スライドショーの自動再生（falseで自動再生なし）
    autoPlay : true,
    // 自動再生時のスライド切替間隔（ミリ秒）
    autoPlayDuration : 2500,
    // キーボードの矢印キーによるスライド送りの設定（trueで有効）
    keyboardOnAlways : true,
    // 1枚目のスライド表示時に戻る矢印を表示するかどうか（falseで非表示）
    hidePrevious : false
  });
});