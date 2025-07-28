import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    this.element.classList.add('fade-out');

    setTimeout(() => {
      this.element.remove()
    }, 3000);
  }
}
