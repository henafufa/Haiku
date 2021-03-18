// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require activestorage

// FB share dialogue config
$('a.share').click(function(e){
    e.preventDefault();
    var $link = $(this);
    var href = $link.attr('href');
    var network = $link.attr('data-network');
   var networks = {
    facebook : { width : 600, height : 300 },
    twitter : { width : 600, height : 254 },
    google : { width : 515, height : 490 },
    linkedin : { width : 600, height : 473 }
    };
   var popup = function(network){
    var options = 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,';
    window.open(href, '', options+'height='+networks[network].height+',width='+networks[network].width);
    };
   popup(network);
   });

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
require("jquery")
import "bootstrap"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// Notification.requestPermission.then(function(result){})