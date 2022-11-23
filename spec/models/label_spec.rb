require 'rails_helper'

RSpec.describe 'ラベルモデル機能', type: :model do
  let!(:user){FactoryBot.create(:user)}
  let!(:label1){FactoryBot.create(:label, user: user)}
  describe 'バリデーションのテスト' do
    context 'ラベルの名前が空文字の場合' do
      it 'バリデーションに失敗する' do
        label = Label.create(name: "", user: user)
        expect(label.errors[:name]).to include("を入力してください")
      end
    end

    context 'ラベルの名前に値があった場合' do
      it 'バリデーションに成功する' do
        expect(label1).to be_valid
      end
    end
  end
end