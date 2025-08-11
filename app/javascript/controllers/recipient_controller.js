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
    const total = recipientContainers.length

    if (total === 1) {
      window.location.href = url;
      return;
    }

    let finished = 0

    Array.from(recipientContainers)
      .forEach(el => {
        if (el !== recipientContainer) {
          el.style.maxHeight = "0px";

          el.addEventListener("transitionend", () => {
            finished++

            if (finished === total - 1) {
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
