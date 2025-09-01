import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="copy"
export default class extends Controller {
  click() {
    var copyText = document.getElementById("copyInput");

    copyText.select();
    copyText.setSelectionRange(0, 99999);

    navigator.clipboard.writeText(copyText.value);

    this.showFlash("Link copied");
  }

  showFlash(message) {
    const turboStream = `
      <turbo-stream action="append" target="flash">
        <template>
          <div data-controller="flash" class="flash-message">
            <div id="notice" class="flash-inner">
              ${message}
              <button type="button" class="flash-close" data-action="flash#close" aria-label="Close">×</button>
            </div>
          </div>
        </template>
      </turbo-stream>
    `;

    Turbo.renderStreamMessage(turboStream);
  }
}
