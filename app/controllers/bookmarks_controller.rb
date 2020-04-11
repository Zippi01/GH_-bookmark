class BookmarksController < ApplicationController
  require 'open-uri'
  require 'nokogiri'

  def index; end

  def new
    @bookmark = Bookmark.new
  end

  def create
    source = parser_pages_params
    page = Nokogiri::HTML.parse(open(source["link"]))
    page.css('div.post__wrapper h1.post__title span.post__title-text').each do |link|
      # puts link.content
    # page.css('div.product-comment div.product-comment__inner div.product-comment__body ').each do |link|
      # word = link.content.split(" ")
      # word.each do |element|
      #   puts element.gsub(/[!@%&",?.]/,'').downcase
      # end
      # @bookmark = Bookmark.new(:comment => link.content.to_s, :url => source["url"])
      # @bookmark.save
    end
    # ParserCreate.call(page, source)
  end

  private

  def parser_pages_params
    params.require(:bookmark).permit(:link)
  end
end
