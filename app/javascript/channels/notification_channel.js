import consumer from "./consumer";

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    console.log("connect your own channel");
  },

  disconnected() {
    console.log("disconnect your own channel!");
  },

  received(data) {
    console.log(data)
    if (data.type == 1) {
      toastr.success(data.content);
    } else {
      toastr.error(data.content);
    }
  },
});
