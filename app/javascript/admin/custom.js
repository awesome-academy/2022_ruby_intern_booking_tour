const moment = require("moment")

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

    if ($(tmp).is(".active.after")) {
      $("#choices").val("after");
    }

    if ($(tmp).is(".active.before")) {
      $("#choices").val("before");
    }

    if ($(tmp).is(".active.specific")) {
      $("#choices").val("specific");
    }

    if ($(tmp).is(".active.between")) {
      $("#choices").val("between");
    }
  });

  let page = 0;
  $("#notifications_admin").scroll(function () {
    var tmp = $(this);
    if (tmp[0].scrollTop + tmp[0].clientHeight == tmp[0].scrollHeight) {
      page++;
      $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: "/admin/filter_ajax",
        data: {
          page: page,
        },
        success: function (o) {
          if (o) {
            o.data = JSON.parse(o.data);
            o.data.forEach((d) => {
              date = moment(d.created_at).format('DD-MM-YYYY, HH:MM:SS');
              tmp.append(`
              <a href="localhost:3000/admin/notifications/${d.id}" method="patch">
              <div class="alert text_black ${d.status === 0 && "alert-info text_white"} ">
              <div class="d-flex">
                <img
                  src="https://bootdey.com/img/Content/avatar/avatar7.png"
                  alt="">
              <div>
                 ${d.content}
              </div>
              <span class="iconify" data-icon="bi:info-circle"></span>
            </div>
            <div class="d-flex mt-3">${date}</div>
            </div>
              </a>`
            );
            });
          }
        },
        error: function (data) {
          console.log("error " + data);
        },
      }).done(function (response) {
        // console.log(response)
      });
    }
  });

  $("#btn__modal").click(function(){
    localStorage.setItem("tour_request_id")
  });
});
