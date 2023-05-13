import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="wines-index"
export default class extends Controller {
  static targets = ["keyword", "maker", "vintage", "country", "region", "wines"]

  connect() {
    console.log(document.querySelector(".filters"))
  }

  fireSubmit() {
    const searchterms = document.querySelectorAll(".searchterm");
    const filters = document.querySelector(".filters");

    for (const searchterm of searchterms) {
      searchterm.addEventListener( 'change', function() {
        Rails.fire(filters, 'submit');
      });
    }
  }


  replaceWines = (results) => {
    const wines = this.winesTarget
    wines.innerHTML = results
  }
}
