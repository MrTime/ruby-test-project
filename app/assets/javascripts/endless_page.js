var currentPage =1;
var kind = 0;
function checkScroll() {
    if (nearBottomOfPage()) {
        currentPage++;
        
        kind = window.location.href.match(/kind=\d+/);
        kind = (kind != null) ? kind[0].match(/\d+/) : 1;

        new Ajax.Request('/books?part=true&page=' + currentPage + '&kind=' + kind, {asynhronous:true, evalScripts:true, method:'get',
                onSuccess: function(response) {
                    jQuery('#books_partial').append(response.responseText);
                    if (response.responseText != " "){
                    checkScroll();
                    }
                }
            }

        )
    } else {
        setTimeout("checkScroll()", 250);
    }
}
function nearBottomOfPage() {
    return scrollDistanceFromBottom() < 50;
}

function scrollDistanceFromBottom(argument) {
    return pageHeight() -(window.pageYOffset + self.innerHeight);
}

function pageHeight(){
    return Math.max(document.body.scrollHeight, document.body.offsetHeight);
}

document.observe('dom:loaded', checkScroll);