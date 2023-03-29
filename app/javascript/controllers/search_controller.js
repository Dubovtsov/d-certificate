import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
    static targets = [ "source", "filterable", "results" ]

    filter(event) {
        let lowerCaseFilterTerm = this.sourceTarget.value.toLowerCase()
        console.log(document.getElementById("department-submit"))
        document.getElementById("department-submit").submit();
        this.sourceTarget.focus();
          // $.get($("#departmens_search").attr("action"), $("#departmens_search").serialize(), null, "script");
          // el.classList.toggle("hidden", !filterableKey.includes( lowerCaseFilterTerm ) )
    }
}
