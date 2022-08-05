$(document).ready(function () {
  var preview = $(".tour__preview");

  $("#tour_image").change(function (event) {
    var input = $(event.currentTarget);
    var file = input[0].files[0];
    var reader = new FileReader();
    console.log(file);
    reader.onload = function (e) {
      var image_base64 = e.target.result;
      preview.attr("src",image_base64);
    };
    reader.readAsDataURL(file);
  });

  $("#tour_image").bind("change",function () {
    var size_in_megabytes = this.files[0].size / 1024 / 1024;
    if (size_in_megabytes > 5) {
      alert("Oversized!!!");
    }
  });

  $(function () {
    $('[data-toggle="tooltip"]').tooltip();
    $(".side-nav .collapse").on("hide.bs.collapse",function () {
      $(this)
        .prev()
        .find(".fa")
        .eq(1)
        .removeClass("fa-angle-right")
        .addClass("fa-angle-down");
    });
    $(".side-nav .collapse").on("show.bs.collapse",function () {
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
    $(".side-nav .collapse").on("hide.bs.collapse",function () {
      $(this)
        .prev()
        .find(".fa")
        .eq(1)
        .removeClass("fa-angle-right")
        .addClass("fa-angle-down");
    });
    $(".side-nav .collapse").on("show.bs.collapse",function () {
      $(this)
        .prev()
        .find(".fa")
        .eq(1)
        .removeClass("fa-angle-down")
        .addClass("fa-angle-right");
    });
  });
});

global.getCookieValue = (name) => (
  document.cookie.match('(^|;)\\s*' + name + '\\s*=\\s*([^;]+)')?.pop() || ''
)

global.eventQuantity = function eventQuantity() {
  $("[id=tour_request_quantity]").each(function () {
    $(this).on("change",() => {
      $(this).parents()[2].nextElementSibling.querySelectorAll("*")[3].value = $(this).parents()[4].children[2].children[0].children[0].innerText.split(' ')[0] * $(this).val();
      $(this).parents()[2].nextElementSibling.nextElementSibling.querySelectorAll("*")[2].removeAttribute('disabled')
    })
  })
};

global.eventRating = function () {
  $("svg.icon-star-empty-form").on("click",function () {
    let temp = $(this).attr("data-star");
    $("#review_rating").val(temp);
    $(this).removeClass('icon-star-empty-form');
    $(this).addClass('icon-star-full-freeze')
    $(this).siblings().removeClass('icon-star-empty-form');
    $(this).nextAll().addClass('icon-star-full-freeze')
    $(this).siblings().off('click');
  })
};

global.eventRatingOnLoad = function () {
  observer = new MutationObserver(() => {
    global.eventRating();
  });
  if ($('.star-rating-form').length > 0) {
    observer.observe($('.star-rating-form')[0],{ attributes: true,childList: true,subtree: true });
  }
};

global.eventReview = function () {
  for (let i = 0; i < 6; i++) {
    $(`#rating_filter_${i}`).on("change",() => {
      Rails.fire($('#search-form')[0],'submit');
    })
  };
}

global.popupMessages = function () {
  $(".custom-social-proof").hide()
  $(".custom-close").click(function () {
    $(".custom-social-proof").stop().slideToggle('slow');
  });
}

$(document).on('turbolinks:load',function () {
  eventQuantity();
  eventReview();
  eventRatingOnLoad();
  $(document).ready(function () {
    eventRating();
  })
});
