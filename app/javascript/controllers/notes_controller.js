import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "errors"];

  connect() {
    console.log("Hello from StimulusJS");
    this.setupFormSubmitListener();
  }

  disconnect() {
    console.log("Goodbye from StimulusJS");
    this.formTarget.removeEventListener("submit", this.handleSubmit);
  }

  setupFormSubmitListener() {
    // Check if the formTarget is available before setting up the event listener
    if (this.hasFormTarget) {
      this.formTarget.addEventListener("submit", this.handleSubmit);
    }
  }

  handleSubmit = (event) => {
    console.log("Form submitted");
    event.preventDefault();
    const form = event.target;
    const url = form.action;
    const formData = new FormData(form);

    console.log("fetching");
    fetch(url, {
      method: "POST",
      body: formData,
    })
      .then((response) => response.text())
      .then((data) => {
        // Handle the response data
        console.log(data);
      })
      .catch((error) => {
        // Handle any errors
        console.error(error);
      });
  };
}
