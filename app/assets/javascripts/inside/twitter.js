/*
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
*/

//function parseParam(){
//  var hash = new Array();
//  var param;
//  if(param = location.search){
//    var parray = param.replace('?','').split('&');
//    for(var i=0; i<parray.length; i++){
//      var n = parray[i].split('=');
//      hash[n[0]] = n[1];
//    }
//  }else{
//    return false;
//  }
//  return hash;
//}
//
//function getParams(){
//  var query = location.search.split('?');
//  var url = "/twitter/" + gi; 
//  if(query.length > 1){
//    for(i = 1; i < query.length; i++){
//      if(i == 1){
//        url += '?' + query[i]
//      }else{
//        url += '&' + query[i]
//      }
//    }
//  }
//  return url;
//}

$(function(){
  　$("#datepicker").datepicker({
    numberOfMonths: 1,
    showButtonPanel: true,
    //minDate: -20, 
    maxDate: "+1M +10D"
  });
  $( "#datepicker" ).datepicker( "option", "dateFormat", "yymmdd" );
});

//ユーザー選択情報の取得
$(document).ready(function(){
  $('#select_user').change(function(){
    gi = $('#gi').val(); 
    location.href = '/twitter/' + gi + '?u=' + $(this).val();
  }); 
});

//日付選択情報の取得
$(document).ready(function(){
  $('#datepicker').change(function(){
    gi = $('#gi').val(); 
    location.href = '/twitter/' + gi + '?dt=' + $(this).val();
  }); 
});

//検索窓からの情報の取得
$(document).ready(function(){
  $('#tweet_search').keypress(function(e){
    if((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)){
      location.href = '/twitter?search=' + $(this).val();
    }   
  }); 
});
