import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clickable"
export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element);
    this.element.style.cursor = 'pointer';
  }

  goToUrl(event) {
    console.log("goToUrl", event.target);
    if (!event.target.closest('a')) {
      let row = event.target.closest('tr');
      let url = row.dataset.clickableUrlValue;
      console.log("URL Value: ", url);
      if (url) window.location = url;
    }
  }


}
