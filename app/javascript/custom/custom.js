$(function () {
    var eventQuantity = function () {
        $("#tour_request_quantity").on("change",() => {
            $("#tour_request_total_price").val($(".price").children()[0].innerText * $("#tour_request_quantity").val());
        })
    };

    $(function () {
        eventQuantity();
    });

    $(document).on('turbolinks:load',function () {
        eventQuantity();
    });
}());
