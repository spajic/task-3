require "rails_helper"

RSpec.describe "CommentsCreate", type: :request do
  let_it_be(:user) { create(:user) }
  let_it_be(:article) { create(:article, user_id: user.id) }

  before do
    sign_in user
  end

  it "creates ordinary article with proper params" do
    new_body = "NEW BODY #{rand(100)}"
    post "/comments", params: {
      comment: { body_markdown: new_body, commentable_id: article.id, commentable_type: "Article" }
    }
    expect(Comment.last.user_id).to eq(user.id)
  end
end
