function isMobile() {
    try {
        if(/Android|webOS|iPhone|iPad|iPod|pocket|psp|kindle|avantgo|blazer|midori|Tablet|Palm|maemo|plucker|phone|BlackBerry|symbian|IEMobile|mobile|ZuneWP7|Windows Phone|Opera Mini/i.test(navigator.userAgent)) {
            return true;
        };
        return false;
    } catch(e){ console.log("Error in isMobile"); return false; }
}

if (isMobile()){



    var ready_mobile = function(){
        $('select').css('height', '35px');
        $('.splitcontentleft').removeClass('splitcontentleft');
        $('.splitcontentright').removeClass('splitcontentright');
        $('input').css('height', '30px');
        $('*:not("#sidebar-btn-slide")').css('font-size','1.02em');
        $('#top-menu').addClass('sb-slidebar').addClass('sb-left');
        if (! document.getElementById('sidebar-btn-slide')) $('#main-menu ul').before('<li id="sidebar-btn-slide" class="sb-toggle-left"><i class="fa fa-bars"></i></li>');
        $.slidebars();
        $('#sidebar-btn-slide').css('font-size','2em');
        $('.list').css('overflow','auto');

        $('.vsplitter').remove();
        $('#sidebar a').css('font-size','1.2em');

        $('#content').css('width','99%');



        $('#sidebar').css('float','none');
        $('#sidebar').css('width','99%');
        $('#sidebar').css('display','inline');



    }

    $(document).ready(function() {
        if (! Turbolinks) ready_mobile();
    });

    $(document).on('page:load page:change page:restore', function(){
        ready_mobile();
    });
}