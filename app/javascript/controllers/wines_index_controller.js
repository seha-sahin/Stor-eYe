import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="wines-index"
export default class extends Controller {
  connect() {
    console.log("wines index controller connected")
  }
}
