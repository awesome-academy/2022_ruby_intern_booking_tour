$(document).ready(function () {
  $(".arrival").click(function () {
    var tmp = $(this);
    $(".arrival").removeClass("active");
    if ($(tmp).is(".arrival")) {
      $(tmp).addClass("active");
    }

    if ($(tmp).is(".active.between")) {
      $("#statistic_start_date").removeClass("none").addClass("display");
      $("#statistic_end_date").removeClass("none").addClass("display");
      $("#statistic_specific_date").removeClass("display").addClass("none");
    } else {
      $("#statistic_start_date").removeClass("display").addClass("none");
      $("#statistic_end_date").removeClass("display").addClass("none");
      $("#statistic_specific_date").removeClass("none").addClass("display");
    }

    if($(tmp).is(".active.after")){
      $("#choices").val("after")
    }

    if($(tmp).is(".active.before")){
      $("#choices").val("before")
    }

    if($(tmp).is(".active.specific")){
      $("#choices").val("specific")
    }

    if($(tmp).is(".active.between")){
      $("#choices").val("between")
    }

  });
});
