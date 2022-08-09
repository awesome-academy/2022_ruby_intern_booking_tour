import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
require("jquery");
import "jquery"
import "../animation/bootstrap-datepicker"
import "../animation/jquery.countTo"
import "../animation/jquery.easing.1.3"
import "../animation/jquery.flexslider-min"
import "../animation/jquery.min"
import "../animation/jquery.waypoints.min"
import "../animation/iconify.min"
import "../animation/main"
import "../custom/custom"
import "../pagy/pagy.js.erb"
global.toastr = require("toastr")

Rails.start();
Turbolinks.start();
ActiveStorage.start();
