require "rails_helper"

RSpec.describe LanguageDetector do
  let_it_be(:user) { create(:user) }
  let_it_be(:article) { create(:article, user_id: user.id) }

  it "returns language" do
    expect(described_class.new(article).detect).to eq("en")
  end
end
