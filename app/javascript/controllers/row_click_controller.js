import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="row-click"
export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element);
    this.element.style.cursor = 'pointer';
  }

  goToUrl(event) {
    console.log("goToUrl", event.target);
    if (!event.target.closest('a')) {
      window.location = this.data.get("url");
    }
  }
}
