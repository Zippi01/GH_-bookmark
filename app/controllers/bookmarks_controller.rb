class BookmarksController < ApplicationController
  require 'open-uri'
  require 'nokogiri'

  def index
    @bookmarks = Bookmark.all.order('created_at DESC')
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    source = parser_pages_params
    page = Nokogiri::HTML.parse(open(source["link"]))

    name = page.css('div.post__wrapper h1.post__title span.post__title-text').text
    body = ''
    # if name != nil
    name = page.css('div.post__wrapper h1.post__title span.post__title-text').text

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
  # else
  #   name = page.css('div.news_single.single_page.shadow_box h1').text
  #   puts name
  #   page.css(' div.kv-post-content-text p').each do |link|
  #     body += link.content + " "
  #   end
  #   puts body
  # end
    @bookmark = Bookmark.new(:name => name, :body => body, :image => image, :category_id => source["category_id"], :link => source["link"])
    @bookmark.save
    redirect_to root_path
  end

  private

  def parser_pages_params
    params.require(:bookmark).permit(:link, :category_id)
  end
end
