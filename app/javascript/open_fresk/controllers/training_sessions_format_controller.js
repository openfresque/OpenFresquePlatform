import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="training-sessions-format"
export default class extends Controller {
  static targets = ["onsite", "online", "onsiteButton", "onlineButton"];

  connect() {
    this.update();
  }

  click() {
    this.update();
  }

  update() {
    const isOnline = this.onlineButtonTarget.checked;

    this.onlineTarget.classList.toggle("d-none", !isOnline);
    this.onsiteTarget.classList.toggle("d-none", isOnline);

    this.toggleInputs(this.onlineTarget, !isOnline);
    this.toggleInputs(this.onsiteTarget, isOnline);
  }

  toggleInputs(target, disabled) {
    const inputs = target.querySelectorAll("input, select, textarea");
    inputs.forEach((input) => {
      input.disabled = disabled;
    });
  }
}
