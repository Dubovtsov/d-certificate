import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = [ "button", "menu" ]

  toggle(event) {
    let button =  event.currentTarget
    this.menuTargets.forEach((el) => {
      if(el == button.nextElementSibling) {
        el.classList.toggle("hidden")
      } else {
        el.classList.add("hidden")
      }
    })
  }
}
