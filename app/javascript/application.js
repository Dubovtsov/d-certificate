// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

function hide(el) {
    el.nextElementSibling.classList.add("hidden")
};

$(document).on("click", ".copytext", function(){
    console.log(this.innerText.trim())
    navigator.clipboard.writeText(this.innerText.trim())
    $(this).attr('title', 'Скопировано')
           .tooltip('show');
    setTimeout(() => 
        $(this).removeAttr('title')
            .tooltip('hide'),
            3000
    )
})

