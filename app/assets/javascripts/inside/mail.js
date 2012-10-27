/*
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
*/


//送信者絞込みのセレクトボックスの選択イベント情報の取得
$(document).ready(function(){
  $('#select_sender').change(function(){
    location.href = '/mail?sender='+$(this).val();
  });
});

//検索窓からの情報の取得
$(document).ready(function(){
  $('#mail_search').keypress(function(e){
    if((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)){
      location.href = '/mail?search=' + $(this).val();
    }
  });
});

