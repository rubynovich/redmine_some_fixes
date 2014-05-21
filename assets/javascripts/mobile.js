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
        $('#top-menu').addClass('sb-slidebar').addClass('sb-left');
        $('#main-menu ul').append('<li class="sb-toggle-left" style="float:right;"><i class="fa fa-bars"></i></li>');
        $.slidebars();
    }

    $(document).ready(function() {
        ready_mobile();
    });

    $(document).on('page:load page:change page:restore', function(){
        ready_mobile();
    });

}