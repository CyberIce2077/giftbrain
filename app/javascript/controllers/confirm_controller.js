import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="confirm"
export default class extends Controller {
  connect() {
    this.modal = document.getElementById("confirm")
    this.title = document.getElementById("confirm-title")
    this.body = document.getElementById("confirm-body")
    this.acceptButton = document.getElementById("confirm-accept")
    this.cancelButtons = this.modal.querySelectorAll(".confirm-cancel")

    this._handleAccept = this._handleAccept.bind(this)
  }

  async click(event) {
    event.preventDefault()
    this._form = this.element.closest("form")
    if (!this._form) return

    this.title.textContent = "Are you sure?"
    this.body.innerHTML = ""

    this.modal.classList.add("modal--active")

    this.acceptButton.addEventListener("click", this._handleAccept, { once: true })

    this.cancelButtons.forEach(btn =>
      btn.addEventListener("click", () => this.modal.classList.remove("modal--active"), { once: true })
    )
  }

  _handleAccept() {
    this.modal.classList.remove("modal--active")
    this._form.submit()
  }
}
