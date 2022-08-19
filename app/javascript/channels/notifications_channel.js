import consumer from "./consumer"

consumer.subscriptions.create({ channel: "NotificationsChannel" },{
  connected() {
    console.log("notification connect!")
  },

  disconnected() {
  },

  received(data) {
    if (getCookieValue('user_id') != data.user_id) {
      $("#popup_messages_name").html(data.user_name);
      $("#popup_messages_tour_quantity").html(data.quantity);
      $("#popup_messages_tour_name").html(data.tour.name);
      $(".custom-social-proof").stop().slideToggle('slow');
      setTimeout(() => {
        $(".custom-social-proof").stop().slideToggle('slow');
      },"5000")
    }
  }
});
