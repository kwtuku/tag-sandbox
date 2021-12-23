require 'rails_helper'

RSpec.describe 'Tags', type: :request do
  describe 'GET /tags?name=:name' do
    before do
      create :tag, name: 'ruby'
      create :tag, name: 'rubyonrails'
      create :tag, name: 'rails'
    end

    it 'returns a 200 response' do
      get tags_path(name: 'ruby')
      expect(response.status).to eq 200
    end

    it 'returns correct tag count' do
      get tags_path(name: 'ruby')
      json = JSON.parse(response.body)
      expect(json['data'].length).to eq 2
    end
  end

  describe 'GET /tags/:name' do
    context 'when the tag of existing name' do
      it 'returns a 200 response' do
        tag = create :tag, name: 'ruby'
        get tag_path('ruby')
        expect(response.status).to eq 200
      end
    end

    context 'when the tag of non-existent name' do
      it 'raises ActiveRecord::RecordNotFound' do
        expect do
          get tag_path('ruby')
        end.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
