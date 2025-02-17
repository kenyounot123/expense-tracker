import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="close-content"
export default class extends Controller {
  static targets = ["content"]

  close() {
    this.contentTarget.style.display = "none"
  }

  connect() {
    console.log("connected")
  }
}
