$(document).ready(function () {
  var preview = $(".tour__preview");

  $("#tour_image").change(function (event) {
    var input = $(event.currentTarget);
    var file = input[0].files[0];
    var reader = new FileReader();
    console.log(file);
    reader.onload = function (e) {
      var image_base64 = e.target.result;
      preview.attr("src", image_base64);
    };
    reader.readAsDataURL(file);
  });

  $("#tour_image").bind("change", function () {
    var size_in_megabytes = this.files[0].size / 1024 / 1024;
    if (size_in_megabytes > 5) {
      alert("Oversized!!!");
    }
  });

  $(function () {
    $('[data-toggle="tooltip"]').tooltip();
    $(".side-nav .collapse").on("hide.bs.collapse", function () {
      $(this)
        .prev()
        .find(".fa")
        .eq(1)
        .removeClass("fa-angle-right")
        .addClass("fa-angle-down");
    });
    $(".side-nav .collapse").on("show.bs.collapse", function () {
      $(this)
        .prev()
        .find(".fa")
        .eq(1)
        .removeClass("fa-angle-down")
        .addClass("fa-angle-right");
    });
  });

  $(function () {
    $('[data-toggle="tooltip"]').tooltip();
    $(".side-nav .collapse").on("hide.bs.collapse", function () {
      $(this)
        .prev()
        .find(".fa")
        .eq(1)
        .removeClass("fa-angle-right")
        .addClass("fa-angle-down");
    });
    $(".side-nav .collapse").on("show.bs.collapse", function () {
      $(this)
        .prev()
        .find(".fa")
        .eq(1)
        .removeClass("fa-angle-down")
        .addClass("fa-angle-right");
    });
  });
});

$(
  (function () {
    var eventQuantity = function () {
      $("#tour_request_quantity").on("change", () => {
        $("#tour_request_total_price").val(
          $(".price").children()[0].innerText *
            $("#tour_request_quantity").val()
        );
      });
    };

    $(function () {
      eventQuantity();
    });

    $(document).on("turbolinks:load", function () {
      eventQuantity();
    });
  })()
);
