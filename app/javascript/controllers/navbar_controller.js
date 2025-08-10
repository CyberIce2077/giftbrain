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
    const height = "261px"

    if (this.menuTarget.style.maxHeight === height) {
      this.menuTarget.style.maxHeight = "0px";
    } else {
      this.menuTarget.style.maxHeight = height;
    }

    console.log(this.menuTarget.style.maxHeight)
  }
}
