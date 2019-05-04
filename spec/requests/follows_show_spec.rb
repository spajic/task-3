require "rails_helper"

RSpec.describe "Follows #show", type: :request do
  let_it_be(:current_user) { create(:user) }
  let_it_be(:user) { create(:user) }
  let_it_be(:tag) { create(:tag) }
  let_it_be(:organization) { create(:organization) }

  before { login_as current_user }

  def get_following_status
    %w[User Organization Tag].map do |type|
      get "/follows/#{send(type.downcase).id}", params: { followable_type: type }
      response.body
    end
  end

  it "rejects unless logged-in" do
    logout
    get "/follows/#{user.id}"
    expect(response.body).to eq("not-logged-in")
  end

  it "returns false when not following" do
    expect(get_following_status.uniq[0]).to eq("false")
  end

  it "returns true when is following" do
    %w[user organization tag].each { |followable| current_user.follow(send(followable)) }
    expect(get_following_status.uniq[0]).to eq("true")
  end

  it "return self if current_user try to follow themself" do
    get "/follows/#{current_user.id}", params: { followable_type: "User" }
    expect(response.body).to eq("self")
  end
end
