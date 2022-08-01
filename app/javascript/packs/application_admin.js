import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
require("jquery");
import "jquery";
import "../animation/iconify.min";
import "../custom/custom";
import "../pagy/pagy.js.erb";
import "bootstrap";

global.toastr = require("toastr")

Rails.start();
Turbolinks.start();
ActiveStorage.start();
