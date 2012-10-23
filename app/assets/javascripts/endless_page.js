var currentPage =1;

function checkScroll() {
    if (nearBottomOfPage()) {
        currentPage++;
        new Ajax.Request('/books?part=true&page=' + currentPage, {asynhronous:true, evalScripts:true, method:'get',
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