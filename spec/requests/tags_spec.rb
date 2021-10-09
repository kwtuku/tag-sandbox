require 'rails_helper'

RSpec.describe 'Tags', type: :request do
  describe 'GET /tags?name=:name' do
    before do
      create :tag, name: 'ruby'
      create :tag, name: 'rubyonrails'
      create :tag, name: 'rails'
    end

    it 'returns a 200 response' do
      get tags_path(name: '')
      expect(response.status).to eq 200
    end

    it 'returns correct tag count' do
      get tags_path(name: 'ruby')
      json = JSON.parse(response.body)
      expect(json['data'].length).to eq 2
    end
  end
end
