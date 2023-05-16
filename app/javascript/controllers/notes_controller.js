import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "errors", "notes"];

  connect() {
    console.log("Hello from StimulusJS");
    this.setupFormSubmitListener();
  }

  disconnect() {
    console.log("Goodbye from StimulusJS");
    if (this.hasFormTarget) {
      this.formTarget.removeEventListener("submit", this.handleSubmit);
    }
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
    .then((response) => response.json())
    .then((data) => {
      if (data.note) {
        const note = data.note;
        const noteHtml = `<div class="card mt-2">
          <div class="card-body">
            <p class="card-text">${note.content}</p>
            <p><strong>Added by:</strong> ${note.user.first_name}</p>
            <p><strong>Added at:</strong> ${new Date(note.created_at).toLocaleString()}</p>
          </div>
        </div>`;
        document.getElementById('notes').prepend(noteHtml);
        document.getElementById('note_content').value = '';
      } else if (data.errors) {
        document.getElementById('note_errors').innerHTML = data.errors;
      }
    })
    .catch((error) => {
      // Handle any errors
      console.error(error);
    });

  };
}
