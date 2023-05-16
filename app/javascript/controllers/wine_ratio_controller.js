import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="wine-ratio"
export default class extends Controller {
  connect() {
    function ratioCalculator() {
      let a = document.querySelector("#unit_price").value;
      let b = document.querySelector("#selling_price").value;
      var calculate;

      if (op == "Calculate Ratio") {
        calculate = a / b * 100
      }
      console.log(calculate);

      document.querySelector("#result_ratio").innerHTML = calculate;
    }
  }
}
