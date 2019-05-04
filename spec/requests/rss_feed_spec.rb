require "rails_helper"

RSpec.describe "RssFeed", type: :request do
  let_it_be(:user) { FactoryBot.create(:user) }
  let_it_be(:organization) { FactoryBot.create(:organization) }
  let_it_be(:article) { FactoryBot.create(:article, user_id: user.id, featured: true) }

  describe "GET query page" do
    it "renders feed" do
      get "/feed"
      expect(response.body).to include("<link>https://dev.to</link>")
    end
    it "renders user feed" do
      get "/feed/#{user.username}"
      expect(response.body).to include("<link>https://dev.to/#{user.username}</link>")
    end
    it "renders organization feed" do
      get "/feed/#{organization.slug}"
      expect(response.body).to include("<link>https://dev.to/#{organization.slug}</link>")
    end
  end
end
