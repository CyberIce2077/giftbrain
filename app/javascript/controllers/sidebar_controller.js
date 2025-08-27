import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  connect() {
    this.visible()
  }

  visible() {
    document.getElementById("sidebar").classList.add("visible")
  }

  invisible() {
    document.getElementById("sidebar").classList.remove("visible")
  }
}
