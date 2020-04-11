class BookmarksController < ApplicationController
  require 'open-uri'
  require 'nokogiri'

  def index
    @bookmarks = Bookmark.all
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    source = parser_pages_params
    page = Nokogiri::HTML.parse(open(source["link"]))

    name = ''
    page.css('div.post__wrapper h1.post__title span.post__title-text').each do |link|
      name += link.content + " "
    end

    body = ''
    page.css('div.post__body.post__body_full div.post__text.post__text-html.post__text_v1').each do |link|
      body += link.content + " "
    end

    image = page.css('div.post__text.post__text-html.post__text_v1 div img').first
    if image == nil
      image = page.css('div.post__text.post__text-html.post__text_v1 img').first.attr('src')
    else
      image = page.css('div.post__text.post__text-html.post__text_v1 div img').first.attr('src')
    end
    puts image

    @bookmark = Bookmark.new(:name => name, :body => body, :image => image, :category_id => source["category_id"], :link => source["link"])
    @bookmark.save
  end

  private

  def parser_pages_params
    params.require(:bookmark).permit(:link, :category_id)
  end
end
