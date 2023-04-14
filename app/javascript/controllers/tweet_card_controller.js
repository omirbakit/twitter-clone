import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails";

// Connects to data-controller="tweet-card"
export default class extends Controller {
  connect() {
    this.element.addEventListener('click', (e) => {
      if (![e.target.dataset.ignoreClick, e.target.parentElement.dataset.ignoreClick].includes('true')) {
        Turbo.visit(this.element.dataset.tweetPath);
      }
    });
  }
}
