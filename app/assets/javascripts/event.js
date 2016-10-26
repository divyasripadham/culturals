$(document).on('ready page:load', function(){
    // alert("Another onload script");
    // alert (gon.menu);
    $("#div_search_name").hide();
    $("#div_search_college").hide();
    $("#div_search_city").hide();
    
    switch (gon.menu) {
      case "upcomingevents":
        $("#btn_upcoming").css("background","lightblue");
        break;
      case "eventsbyname":
        $("#btn_name").css("background","lightblue");
        eventsbynamefn();
        $("#btn_upcoming").css("background","white");
        $("#btn_college").css("background","white");
        $("#btn_city").css("background","white");
        break;
      case "eventsbycollege":
        $("#btn_college").css("background","lightblue");
        eventsbycollegefn();
        $("#btn_upcoming").css("background","white");
        $("#btn_name").css("background","white");
        $("#btn_city").css("background","white");
        break;
      case "eventsbycity":
        $("#btn_city").css("background","lightblue");
        eventsbycityfn();
        $("#btn_upcoming").css("background","white");
        $("#btn_name").css("background","white");
        $("#btn_college").css("background","white");
        break;
      default:

    }
    $("#btn_upcoming").click(function(){
        $("#div_search_name").hide();
        $("#div_search_college").hide();
        $("#div_search_city").hide();
        $(this).css("background","lightblue");
        $("#btn_name").css("background","white");
        $("#btn_college").css("background","white");
        $("#btn_city").css("background","white");
    });
    $("#btn_name").click(function(){
        eventsbynamefn();
    });
    $("#btn_college").click(function(){
        eventsbycollegefn();
    });
    $("#btn_city").click(function(){
        eventsbycityfn();
    });
});

function eventsbynamefn(){
  $("#div_search_name").show();
  $("#div_search_college").hide();
  $("#div_search_city").hide();
}
function eventsbycollegefn() {
  $("#div_search_name").hide();
  $("#div_search_college").show();
  $("#div_search_city").hide();
}
function eventsbycityfn() {
  $("#div_search_name").hide();
  $("#div_search_college").hide();
  $("#div_search_city").show();
}