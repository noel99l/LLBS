// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//= require rails-ujs
//= require activestorage
//= require jquery
//= require bootstrap-sprockets
//= require cocoon
//= require moment
//= require moment/ja.js
//= require bootstrap-datetimepicker
//= require trix
//= require_tree .


// タイムテーブル並べ替え
$(function(){
  // トークンの取得
  $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
      var token;
      if (!options.crossDomain) {
        token = $('meta[name="csrf-token"]').attr('content');
        if (token) {
            return jqXHR.setRequestHeader('X-CSRF-Token', token);
        }
      }
  });

  // テーブルの横幅をとってくる
  function fixPlaceHolderWidth(event, ui){
    // adjust placeholder td width to original td width
    ui.children().each(function(){
        $(this).width($(this).width());
    });
    return ui;
  };
  // sortable
    var el = document.getElementById('sortable');
    if (el !== null) {
      return sortable = Sortable.create(el, {
        // テーブルの横幅をそのままに
        start: function(event, ui){
            ui.placeholder.height(ui.helper.outerHeight());
        },
        helper: fixPlaceHolderWidth,
        // 移動した時
        onUpdate: function(evt) {
          return $.ajax({
            url: 'timetable/sort',
            type: 'patch',
            data:{
              from: evt.oldIndex,
              to: evt.newIndex
            }
          });
        }
      });
  };
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
  geocoder.geocode({
    address: address
  }, function(results, status) {
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

var data = {'data-format': 'yyyy-MM-dd hh:mm:ss' };
$(function(){
    $('.datepicker').attr(data);
    $('.datepicker').datetimepicker();
});