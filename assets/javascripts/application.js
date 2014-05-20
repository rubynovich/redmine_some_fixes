//= require ./colResizable-1.3.min.js
//= require ./jquery.turbolinks
//= require ./turbolinks
//= require ./select2
//= require ./select2_locale_ru.js


var doc_ready = function(){
    $('.icon.icon-zoo, .icon.icon-zoom-out, .icon.icon-zoom-in, a[href="#"], a[data-remote="true"], a.icon.icon-user[href^="/users/"], a[href*="/gantt?id="], a.advanced-gantt').attr('data-no-turbolink','true');

}

$(document).on('click', 'a.icon.icon-zoom-in', function(e){
    e.preventDefault();

    $('#content').css({'width':  $(window).width() - parseInt($('#sidebar').width())+'px' });
    $('#main').split({orientation:'vertical', limit:100, position:'75%', panel1: '#content', panel2: '#sidebar' });
    window.splitter_sidebar.refresh();
    window.splitter_sidebar.trigger('resize');
})

$(document).ready(function() {
    doc_ready();
});

$(document).on('page:load page:change page:restore', function(){
    doc_ready();
});