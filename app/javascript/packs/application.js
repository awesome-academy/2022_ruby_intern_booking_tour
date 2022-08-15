import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
require("jquery");
import "jquery"
import "channels";
import "../animation/bootstrap-datepicker"
import "../animation/jquery.countTo"
import "../animation/jquery.easing.1.3"
import "../animation/jquery.flexslider-min"
import "../animation/jquery.min"
import "../animation/jquery.waypoints.min"
import "../animation/iconify.min"
import "../animation/main"
global.Rails = require("@rails/ujs")
import "../custom/custom"
import "bootstrap"
import "../pagy/pagy.js.erb"
global.toastr = require("toastr")

Rails.start();
Turbolinks.start();
ActiveStorage.start();
