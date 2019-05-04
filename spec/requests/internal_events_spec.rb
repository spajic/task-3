require "rails_helper"

RSpec.describe "Internal Events", type: :request do
  let_it_be(:event) { create(:event) }
  let_it_be(:admin) { create(:user, :super_admin) }

  describe "PUT internal/events" do
    before do
      login_as(admin)
    end

    it "marks an event as not live now" do
      event.update(live_now: true)
      patch "/internal/events/#{event.id}", params: { event: { live_now: "0" } }
      expect(event.reload.live_now).to eq false
    end

    it "marks an event as live now" do
      patch "/internal/events/#{event.id}", params: { event: { live_now: "1" } }
      expect(event.reload.live_now).to eq true
    end
  end
end
