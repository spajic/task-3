require "rails_helper"

RSpec.describe "ImageUploads", type: :request do
  describe "POST/image_uploads" do
    let_it_be(:user) { create(:user) }
    let_it_be(:headers) { { "Content-Type": "application/json", Accept: "application/json" } }
    let_it_be(:image) do
      Rack::Test::UploadedFile.new(
        File.join(Rails.root, "spec", "support", "fixtures", "images", "image1.jpeg"),
        "image/jpeg",
      )
    end
    let_it_be(:bad_image) do
      Rack::Test::UploadedFile.new(
        File.join(Rails.root, "spec", "support", "fixtures", "images", "bad-image.jpg"),
        "image/jpeg",
      )
    end

    context "when not logged-in" do
      it "responds with 401" do
        post "/image_uploads", headers: headers
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when logged-in" do
      before do
        sign_in user
      end

      it "returns json" do
        post "/image_uploads", headers: headers
        expect(response.content_type).to eq("application/json")
      end

      it "provides a link" do
        # this test is a little flimsy
        post "/image_uploads", headers: headers, params: { image: image }
        expect(response.body).to match("\/i\/.+\.")
      end

      it "prevents image with resolutions larger than 4096x4096" do
        post "/image_uploads", headers: headers, params: { image: bad_image }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns a JSON error if something goes wrong" do
        post "/image_uploads", headers: headers, params: { image: bad_image }
        result = JSON.parse(response.body)
        expect(result["error"]).not_to be_nil
      end
    end
  end
end
