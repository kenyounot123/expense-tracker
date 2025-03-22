import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["multiselect"]

  connect() {
    document.addEventListener("multiselect-addable", this.handleAddable.bind(this))
  }

  disconnect() {
    document.removeEventListener("multiselect-addable", this.handleAddable.bind(this))
  }

  async handleAddable(event) {
    const multiselectElement = this.multiselectTarget
    const searchInput = multiselectElement.querySelector("input.multiselect__search")
    const query = searchInput.value

    try {
      const response = await fetch("/categories/create_from_select", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
        },
        body: JSON.stringify({ addable: query })
      })

      if (!response.ok) throw new Error("Network response was not ok")

      const data = await response.json()
      const multiselectController = this.application.getControllerForElementAndIdentifier(
        multiselectElement,
        "multiselect"
      )
      
      multiselectController.addAddableItem(data)
    } catch (error) {
      console.error("Error creating category:", error)
    }
  }
} 