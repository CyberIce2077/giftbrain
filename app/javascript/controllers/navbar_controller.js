import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["menu"]

  connect() {
    if (this.element.dataset.toogleMenu === "") {
      this.toggle()
    }
  }

  toggle() {
    this.menuTarget.classList.toggle("nav-menu-hidden")
  }
}
