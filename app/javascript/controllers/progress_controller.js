import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="progress"
export default class extends Controller {
  static values = {
    status: String,
    duration: Number
  }

  connect() {
    if (this.statusValue === "processing") {
      this.startProgress()
    } else if (this.statusValue === "finishing") {
      this.setProgress(99)
    } else if (this.statusValue === "success") {
      this.setProgress(100)
    } else if (this.statusValue === "failed") {
      this.setProgress(100)
    } else {
      this.setProgress(0)
    }
  }

  startProgress() {
    this.barElement.style.width = "0%"
    const durationMs = this.durationValue * 1000
    const start = Date.now()

    this.interval = setInterval(() => {
      const elapsed = Date.now() - start
      const percent = Math.min((elapsed / durationMs) * 100, 99)
      this.setProgress(percent)

      if (percent >= 99) {
        clearInterval(this.interval)
      }
    }, 10)
  }

  setProgress(percent) {
    this.barElement.style.width = `${percent}%`
  }

  get barElement() {
    return this.element.querySelector("[data-progress-target='bar']")
  }
}
