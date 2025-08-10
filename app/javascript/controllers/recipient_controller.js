import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="recipient"
export default class extends Controller {
  connect() {
  }

  show(event) {
    event.preventDefault()

    const url = event.currentTarget.href
    const recipientContainer = event.currentTarget.closest(".recipient-container");
    const recipientContainers = document.getElementsByClassName("recipient-container")

    let finished = 0
    const total = recipientContainers.length - 1

    Array.from(recipientContainers)
      .forEach(el => {
        if (el !== recipientContainer) {
          el.style.maxHeight = "0px";

          el.addEventListener("transitionend", () => {
            finished++

            if (finished === total) {
              setTimeout(() => {
                window.location.href = url
              }, 100);
            }

            el.parentElement.remove()
          }, { once: true })
        }
      });
  }
}
