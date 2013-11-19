// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function remove_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $(link).parent().before(content.replace(regexp, new_id));
}

function show_share_form(deal_id){
    $.ajax({
        url: "/deals/"+deal_id+"/share_with_friends",
        success: function(data) {
            $('#popup_body').html(data);
            $('#overlay').show();
            $('#popup_box').show();
            $('show_form').show();
        }
    });
}

function hide_popup(){

    if(jQuery('#popup_box')){
        jQuery('#popup_body').html("");
        jQuery('#popup_box').hide();
    }
    if(jQuery('#overlay')){
        jQuery('#overlay').hide();
    }
}

function set_time_zone(){
    var now = new Date();
    var gmtoffset = now.getTimezoneOffset();

    $.ajax({
        url: '/home/gmtoffset/?gmtoffset='+gmtoffset
    });
}
