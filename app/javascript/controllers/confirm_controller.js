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
    this._handleCancel = this._handleCancel.bind(this)
  }

  click(event) {
    event.preventDefault()

    this._form = this.element.closest("form")
    if (!this._form) return

    this._turbo_stream = this.element.dataset.turboStream === "true"
    this.title.textContent = "Are you sure?"
    this.body.innerHTML = ""

    this._cleanupListeners()

    this.modal.classList.add("modal-active")

    this.acceptButton.addEventListener("click", this._handleAccept)
    this.cancelButtons.forEach(btn =>
      btn.addEventListener("click", this._handleCancel)
    )
  }

  _handleAccept() {
    this.modal.classList.remove("modal-active")

    if (this._turbo_stream) {
      this._form.requestSubmit()
    } else {
      this._form.submit()
    }

    this._cleanupListeners()
    this._form = null
  }

  _handleCancel() {
    this.modal.classList.remove("modal-active")
    this._cleanupListeners()
    this._form = null
  }

  _cleanupListeners() {
    this.acceptButton.removeEventListener("click", this._handleAccept)

    this.cancelButtons.forEach(btn =>
      btn.removeEventListener("click", this._handleCancel)
    )
  }
}
