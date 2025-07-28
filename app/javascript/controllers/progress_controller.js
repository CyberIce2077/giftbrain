import { Controller } from "@hotwired/stimulus"
import ProgressBar from "progressbar.js"

// Connects to data-controller="progress"
export default class extends Controller {
  static values = {
    status: String
  }

  connect() {
    this.bar = new ProgressBar.Line(this.element, {
      strokeWidth: 4,
      easing: 'easeInOut',
      duration: 1400,
      color: '#F7BF6B',
      trailColor: '#eee',
      trailWidth: 1,
      svgStyle: {width: '100%', height: '100%'},
      from: {color: '#F7BF6B'},
      to: {color: '#CC3C2E'},
      step: (state, bar) => {
        bar.path.setAttribute('stroke', state.color);
      }
    });

    this.handleStatus(this.statusValue)
  }

  handleStatus(status) {
    if (status === "processing") {
      this.startFakeProgress()
    } else if (status === "finishing") {
      this.progress = 0.99
      this.bar.set(this.progress)
    } else if (status === "success" || status === "failed") {
      this.progress = 1
      this.bar.set(this.progress)
    }
  }

  startFakeProgress() {
    this.progress = 0
    this.interval = setInterval(() => {
      if (this.progress < 0.99) {
        this.progress += 0.01
        this.bar.animate(this.progress)
      }
    }, 1200) // it takes 2 minutes to complete the process
  }
}
