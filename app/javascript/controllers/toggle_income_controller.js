import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-income"
export default class extends Controller {
  static targets = ["submitButtonText"]

  toggle(event) {
    if (event.target.checked) {
      this.submitButtonTextTarget.textContent = "Add Income"
      this.submitButtonTextTarget.value = "Add Income"
      this.submitButtonTextTarget.classList.add("btn-secondary")
      this.submitButtonTextTarget.classList.remove("btn-primary")
    } else {
      this.submitButtonTextTarget.textContent = "Add Expense"
      this.submitButtonTextTarget.value = "Add Expense"
      this.submitButtonTextTarget.classList.add("btn-primary")
      this.submitButtonTextTarget.classList.remove("btn-secondary")
    }
  }
}
