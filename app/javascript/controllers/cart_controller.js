import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "button"]

  submit(_event) {
    this.buttonTarget.disabled = true
    this.buttonTarget.innerText = "Adding..."
    this.formTarget.requestSubmit()
  }
}