import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  // static targets = ["menu"]

  // connect() {
  //   if (this.element.dataset.toogleMenu === "") {
  //     this.toggle()
  //   }
  // }

  // toggle() {
  //   const height = "350px"

  //   if (this.menuTarget.style.maxHeight === height) {
  //     this.menuTarget.style.maxHeight = "0px";
  //   } else {
  //     this.menuTarget.style.maxHeight = height;
  //   }
  // }

  connect() {
    this.previousScrollY = window.scrollY
    this.scrolledDownOnce = false

    window.addEventListener("scroll", this.onScroll.bind(this))
  }

  disconnect() {
    window.removeEventListener("scroll", this.onScroll.bind(this))
  }

  onScroll() {
    const currentScrollY = window.scrollY

    // Когато скролнем надолу (и не сме го засекли още)
    if (currentScrollY > this.previousScrollY && !this.scrolledDownOnce) {
      this.scrolledDownOnce = true
      this.handleScrollDown()
    }

    // Когато сме най-горе
    if (currentScrollY === 0 && this.scrolledDownOnce) {
      this.scrolledDownOnce = false
      this.handleBackToTop()
    }

    this.previousScrollY = currentScrollY
  }

  handleScrollDown() {
    console.log("Scrolled down")

    document.getElementById("navbar-center-container").style.width = "25%"
  }

  handleBackToTop() {
    console.log("Back to top")

    document.getElementById("navbar-center-container").style.width = "50%"
  }
}
