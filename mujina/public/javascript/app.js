var source = $("#tv-guide-template").html();
var template = Handlebars.compile(source);

$.get( "/api/tv/guide/1/2", function( data ) {
    $("#tv_guide").html(template(data));
});
