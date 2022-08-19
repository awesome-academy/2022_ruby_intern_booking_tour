import consumer from "./consumer";
const moment = require("moment");

consumer.subscriptions.create("AdminChannel", {
  connected() {
    console.log("connect admin channel!");
  },

  disconnected() {
    console.log("disconnect admin channel");
  },

  received(data) {
    console.log(data);
    if (data.type == 1) {
      toastr.success(data.content);
    } else {
      toastr.error(data.content);
    }
    $("#bell_ring").removeClass("none").addClass("display");
    let date = moment().format("DD-MM-YYYY, HH:MM:SS");
    $("#notifications_admin").prepend(
      `
      <a href="/vi/admin/tour_requests/${data.tour_request.id}?notification_id=${data.notification.id}">
      <div class="alert text_black alert-info text_white ">
    <div class="d-flex">
      <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="">
    <div>
      ${data.content}
    </div>
    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" class="iconify iconify--bi" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 16 16" data-icon="bi:info-circle"><g fill="currentColor"><path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"></path><path d="m8.93 6.588l-2.29.287l-.082.38l.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319c.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246c-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0a1 1 0 0 1 2 0z"></path></g></svg>
  </div>
  <div class="d-flex mt-3">${date}</div>
  </div>
</a>
      `
    );
  },
});
