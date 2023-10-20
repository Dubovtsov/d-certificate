import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "tab", "content", "tabContentItem" ]

  changeTab(event) {
    event.preventDefault() 
    this.tabTargets.forEach(tab => {
        tab.classList.remove('active') 
    }) 
    event.target.classList.add('active') 
    this.tabContentItemTargets.forEach(content => {
        content.classList.remove('active')
        content.hidden = true
    })
    const tabId = event.target.dataset.tabId
    const tabContent = this.tabContentItemTargets.find(tabContent => tabContent.dataset.tabId === tabId) 
    tabContent.classList.add('active')
    tabContent.hidden = false
  } 

}
