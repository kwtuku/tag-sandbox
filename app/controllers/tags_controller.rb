class TagsController < ApplicationController
  def index
    tags = Tag.where('name LIKE ?', "%#{Tag.sanitize_sql_like(params[:name])}%").pluck(:name).first(5)
    render json: { message: 'Loaded tags', data: tags }, status: :ok
  end

  def show
    @tag = Tag.find_by(name: params[:name])
    raise ActiveRecord::RecordNotFound unless @tag

    @tagged_articles = Article.tagged_with(@tag.name)
  end
end
