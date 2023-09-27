import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tweet-polling"
export default class extends Controller {
  headers = { 'Accept': 'text/vnd.turbo-stream.html' };

  connect() {
    setInterval(() => {
      if (this.element.dataset.latestTweetId.length > 0) {
        fetch(`/tweet_polling?latest_tweet_id=${this.element.dataset.latestTweetId}`, { headers: this.headers })
          .then(response => response.text())
          .then(html => Turbo.renderStreamMessage(html))
      }
    }, 3000);
  }
}
