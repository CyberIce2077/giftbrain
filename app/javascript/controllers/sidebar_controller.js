import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  visible() {
    const sidebar = document.getElementById("sidebar")
    const backdrop = document.getElementById("sidebar-backdrop")

    sidebar.classList.add("visible")
    backdrop.classList.add("visible")
  }

  invisible() {
    const sidebar = document.getElementById("sidebar")
    const backdrop = document.getElementById("sidebar-backdrop")

    sidebar.classList.remove("visible")
    backdrop.classList.remove("visible")
  }
}
