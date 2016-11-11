$(document).on('ready page:load', function(){
    // alert("Another onload script");
    // alert (gon.menu);
    $("#div_search_video_title").hide();
    $("#div_search_video_college").hide();
    $("#div_search_video_event").hide();
    $("#div_search_video_type").hide();

    switch (gon.menu) {
      case "recentvideos":
        $("#btn_video_upcoming").css("background","lightblue");
        break;
      case "videosbytitle":
        $("#btn_video_title").css("background","lightblue");
        videosbytitlefn();
        $("#btn_video_upcoming").css("background","white");
        $("#btn_video_college").css("background","white");
        $("#btn_video_event").css("background","white");
        $("#btn_video_type").css("background","white");
        break;
      case "videosbycollege":
        $("#btn_video_college").css("background","lightblue");
        videosbycollegefn();
        $("#btn_video_upcoming").css("background","white");
        $("#btn_video_title").css("background","white");
        $("#btn_video_event").css("background","white");
        $("#btn_video_type").css("background","white");
        break;
      case "videosbyevent":
        $("#btn_video_event").css("background","lightblue");
        videosbyeventfn();
        $("#btn_video_upcoming").css("background","white");
        $("#btn_video_title").css("background","white");
        $("#btn_video_college").css("background","white");
        $("#btn_video_type").css("background","white");
        break;
      case "videosbytype":
        $("#btn_video_type").css("background","lightblue");
        videosbytypefn();
        $("#btn_video_upcoming").css("background","white");
        $("#btn_video_title").css("background","white");
        $("#btn_video_college").css("background","white");
        $("#btn_video_event").css("background","white");
        break;
      default:

    }
    $("#btn_video_upcoming").click(function(){
        $("#div_search_video_title").hide();
        $("#div_search_video_college").hide();
        $("#div_search_video_event").hide();
        $("#div_search_video_type").hide();
        $(this).css("background","lightblue");
        $("#btn_video_title").css("background","white");
        $("#btn_video_college").css("background","white");
        $("#btn_video_event").css("background","white");
        $("#btn_video_type").css("background","white");
    });
    $("#btn_video_title").click(function(){
        videosbytitlefn();
    });
    $("#btn_video_college").click(function(){
        videosbycollegefn();
    });
    $("#btn_video_event").click(function(){
        videosbyeventfn();
    });
    $("#btn_video_type").click(function(){
        videosbytypefn();
    });
});

function videosbytitlefn(){
  $("#div_search_video_title").show();
  $("#div_search_video_college").hide();
  $("#div_search_video_event").hide();
  $("#div_search_video_type").hide();
}
function videosbycollegefn() {
  $("#div_search_video_title").hide();
  $("#div_search_video_college").show();
  $("#div_search_video_event").hide();
  $("#div_search_video_type").hide();
}
function videosbyeventfn() {
  $("#div_search_video_title").hide();
  $("#div_search_video_college").hide();
  $("#div_search_video_event").show();
  $("#div_search_video_type").hide();
}
function videosbytypefn() {
  $("#div_search_video_title").hide();
  $("#div_search_video_college").hide();
  $("#div_search_video_event").hide();
  $("#div_search_video_type").show();
}
