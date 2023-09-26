import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails";

// Connects to data-controller="dashboard-tweets"
export default class extends Controller {
  headers = { 'Accept': 'text/vnd.turbo-stream.html' };

  connect() {
    window.addEventListener('scroll', () => {
      if (window.innerHeight + window.pageYOffset >= document.body.offsetHeight) {
        if (this.element.dataset.lastPage === 'false') {
          fetch(`/?page=${this.element.dataset.nextPage}`, { headers: this.headers })
            .then(response => response.text())
            .then(html => Turbo.renderStreamMessage(html))
        }
      }
    });
  }
}
