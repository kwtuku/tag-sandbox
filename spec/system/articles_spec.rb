require 'rails_helper'

RSpec.describe 'Articles', type: :system do
  context 'when user fills out a form with no tags' do
    it 'creates a new article', js: true do
      visit new_article_path
      fill_in 'article[title]', with: 'title'
      fill_in 'article[body]', with: 'body'
      expect do
        click_button '登録する'
      end.to change(Article, :count).by(1)
      expect(page).to have_content 'Article was successfully created.'
    end
  end

  context 'when user fills out a form with 5 tags' do
    it 'creates a new article', js: true do
      visit new_article_path
      fill_in 'article[title]', with: 'title'
      fill_in 'article[body]', with: 'body'
      fill_in 'article[tag_list]', with: 'ruby,php,python,go,c', visible: false
      expect do
        click_button '登録する'
      end.to change(Article, :count).by(1)
        .and change(Tag, :count).by(5)
      expect(page).to have_content 'Article was successfully created.'
    end
  end
end
