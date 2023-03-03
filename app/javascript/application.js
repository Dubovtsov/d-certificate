// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

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