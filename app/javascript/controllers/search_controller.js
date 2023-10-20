import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "source", "filterable", "results" ]

    filter(event) {
        let lowerCaseFilterTerm = this.sourceTarget.value.toLowerCase()
        this.filterableTargets.forEach((el, i) => {
            let filterableKey =  el.getAttribute("data-search-key")
            el.classList.toggle("hidden", !filterableKey.includes( lowerCaseFilterTerm ) )
        })
    }
}
