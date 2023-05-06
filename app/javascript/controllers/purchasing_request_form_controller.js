// purchasing_request_form_controller.js

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "wineFields" ]

  connect() {
    console.log("Initialize function called")
    this.hideAllWineFields()
  }

  supplierChanged(event) {
    const supplier_id = event.target.value;
    console.log("Selected supplier ID:", supplier_id);

    if (supplierId) {
      const supplierId = this.element.getAttribute('data-supplier-id');

      // show the wine fields for the selected supplier
      const wineFields = this.wineFieldsTargets.find(
        (element) => element.dataset.supplierId === supplierId
      );
      this.hideAllWineFields();
      wineFields.style.display = "block";
    } else {
      // no supplier selected, hide all wine fields
      this.hideAllWineFields();
      console.log("No supplier selected");
    }
  }



  hideAllWineFields() {
    const wineFields = this.element.querySelectorAll(".wine-fields")
    wineFields.forEach((field) => field.style.display = "none")
  }
}
