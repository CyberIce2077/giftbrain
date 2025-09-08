import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ai-glow"
export default class extends Controller {
  connect() {
    this.degrees = 0
    this.raf = null
    this.animateGlow()
  }

  disconnect() {
    if (this.raf) cancelAnimationFrame(this.raf)
  }

  animateGlow() {
    this.degrees = (this.degrees + 1) % 360
    this.element.style.setProperty('--ai-glow-angle', `${this.degrees}deg`)
    this.raf = requestAnimationFrame(() => this.animateGlow())
  }
}
