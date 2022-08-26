import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
require("jquery");
import "jquery";
import "../animation/iconify.min";
import "../admin/jquery.min";
import "../admin/popper.min";
// import "../admin/bootstrap.min";
import "../admin/perfect-scrollbar.jquery.min";
import "../admin/chartjs.min";
import "../admin/bootstrap-notify";
import "../custom/custom";
import "../admin/custom";
import "../pagy/pagy.js.erb";
import "bootstrap";

global.toastr = require("toastr");

Rails.start();
Turbolinks.start();
ActiveStorage.start();
