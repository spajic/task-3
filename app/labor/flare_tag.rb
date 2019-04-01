class FlareTag
  FLARES = %w[explainlikeimfive
              ama
              techtalks
              help
              news
              healthydebate
              showdev
              challenge
              anonymous
              hiring
              discuss].freeze

  def initialize(article, except_tag = nil)
    @article = article.decorate
    @except_tag = except_tag
  end

  def tag
    @tag ||= Rails.cache.fetch("article_flare_tag-#{article.id}-#{article.updated_at}", expires_in: 12.hours) do
      flare = (FLARES & article.cached_tag_list_array)[0]
      flare && flare != except_tag ? Tag.select(:name, :bg_color_hex, :text_color_hex).find_by(name: flare) : nil
    end
  end

  def tag_hash
    return unless tag

    tag.attributes.symbolize_keys!
  end

  private

  attr_reader :article, :except_tag
end
