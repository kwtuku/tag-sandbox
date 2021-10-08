class TagsController < ApplicationController
  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @tagged_articles = Article.tagged_with(@tag.name)
  end
end
