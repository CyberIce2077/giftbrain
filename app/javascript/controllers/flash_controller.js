import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static values = {
    timeout: { type: Number, default: 3000 }
  }

  connect() {
    this.timeoutId = setTimeout(() => this.close(), this.timeoutValue)
  }

  close() {
    clearTimeout(this.timeoutId)
    this.element.classList.add("fade-out")
    setTimeout(() => this.element.remove(), 1000)
  }
}
