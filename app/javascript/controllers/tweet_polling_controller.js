import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tweet-polling"
export default class extends Controller {
  headers = { 'Accept': 'text/vnd.turbo-stream.html' };

  connect() {
    // fetch(`/dashboard?page=${this.element.dataset.nextPage}`, { headers: this.headers })
    //   .then(response => response.text())
    //   .then(html => Turbo.renderStreamMessage(html));
  }
}
