import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-income"
export default class extends Controller {
  static targets = ["submitButtonText", "checkboxLabel"]

  connect() {
    this.updateUI()
  }

  toggle() {
    this.updateUI()
  }

  updateUI() {
    const isIncome = this.element.querySelector('input[type="checkbox"]').checked

    // Update submit button text
    if (this.hasSubmitButtonTextTarget) {
      this.submitButtonTextTarget.textContent = isIncome ? "Add Income" : "Add Expense"
      this.submitButtonTextTarget.classList.toggle('bg-accent', isIncome)
      this.submitButtonTextTarget.classList.toggle('bg-positive', !isIncome)
    }
  }
}
