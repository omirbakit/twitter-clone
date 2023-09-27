require "rails_helper"

RSpec.describe "TweetPolling", type: :request do
	let(:user) { create(:user) }

	before { sign_in user }

	describe "GET index" do
		it "succeeds" do
			get tweet_polling_path, headers: { 'Accept': 'text/vnd.turbo-stream.html' }
			expect(response).to have_http_status(:success)
		end
	end
end