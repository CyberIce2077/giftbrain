import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="recipient"
export default class extends Controller {
  connect() {
  }

  show(event) {
    event.preventDefault()

    const url = event.currentTarget.href
    const self = event.currentTarget.closest(".recipient-container");

    Array.from(document.getElementsByClassName("recipient-container"))
      .forEach(el => {
        if (el !== self) {
          el.style.maxHeight = "0px";

          setTimeout(() => {
            el.parentElement.remove();
          }, 500);
        }
      });

    setTimeout(() => {
      window.location.href = url
    }, 500);
  }
}
