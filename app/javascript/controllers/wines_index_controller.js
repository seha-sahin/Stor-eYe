import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="wines-index"
export default class extends Controller {
  static targets = ["amount"]

  connect() {
    this.resetAmount(this.amountTarget)
  }

  resetAmount = (amount) => {
      amount.defaultValue = 0
  }
}
