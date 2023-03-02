import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
    static targets = [ "source", "filterable" ]

    filter(event) {
        let lowerCaseFilterTerm = this.sourceTarget.value.toLowerCase()
    
        this.filterableTargets.forEach((el, i) => {
          let filterableKey =  el.getAttribute("data-search-key")
    
          el.classList.toggle("hidden", !filterableKey.includes( lowerCaseFilterTerm ) )
        })
    }
}
