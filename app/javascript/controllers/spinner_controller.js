import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spinner"
export default class extends Controller {
  connect() {
    document.getElementById("spinner").style.display = "none"
  }

  disconnect() {
    document.getElementById("spinner").style.display = "none"
  }

  start() {
    document.getElementById("spinner").style.display = "flex"
  }
}
