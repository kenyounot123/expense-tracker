import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu"]

  hide(event) {
    if (this.element.contains(event.target)) return
    this.menuTarget.style.display = "none"
  }

  connect() {
    this.menuTarget.style.display = "none"
  }

  toggle() {
    if (this.menuTarget.style.display === "none") {
      this.menuTarget.style.display = "block"
    } else {
      this.menuTarget.style.display = "none"
    }
  }
}
