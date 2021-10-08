require 'rails_helper'

RSpec.describe 'Articles', type: :system do
  context 'with no tags' do
    it 'creates a new article', js: true do
      visit articles_path
      click_link 'New Article'
      fill_in 'article[title]', with: 'title'
      fill_in 'article[body]', with: 'body'
      expect do
        click_button '登録する'
      end.to change(Article, :count).by(1)
      expect(page).to have_content 'Article was successfully created.'
    end
  end

  context 'with 5 tags' do
    it 'creates a new article', js: true do
      visit articles_path
      click_link 'New Article'
      fill_in 'article[title]', with: 'title'
      fill_in 'article[body]', with: 'body'
      fill_in 'article[tag_list]', with: 'ruby, php, python, go, c', visible: false
      expect do
        click_button '登録する'
      end.to change(Article, :count).by(1)
      expect(page).to have_content 'Article was successfully created.'
    end
  end

  context 'with 6 tags' do
    it 'cannot create a new article', js: true do
      visit articles_path
      click_link 'New Article'
      fill_in 'article[title]', with: 'title'
      fill_in 'article[body]', with: 'body'
      fill_in 'article[tag_list]', with: 'ruby, php, python, go, c, java', visible: false
      expect do
        click_button '登録する'
      end.to change(Article, :count).by(0)
      expect(page).to have_content 'タグは5つ以下にしてください。'
    end
  end
end
