require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'full_title helper' do
    context 'no argument' do
      it 'return "Sample App"' do
        expect(full_title).to eq('Sample App')
      end
    end
    context 'argument is "Help"' do
      it 'return "Help | Sample App"' do
        expect(full_title('Help')).to eq('Help | Sample App')
      end
    end
  end
end
