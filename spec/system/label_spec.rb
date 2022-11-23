require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:user){FactoryBot.create(:user)}
  describe '登録機能' do
    before do
      visit new_session_path #userをログインさせる
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_button 'ログイン'
    end
    context 'ラベルを登録した場合' do
      it '登録したラベルが表示される' do
        visit new_label_path
        fill_in('label_name', with: '豆柴')
        click_on('登録する')
        expect(page).to have_content '豆柴'
      end
    end
  end
  describe '一覧表示機能' do
    before do
      visit new_session_path #userをログインさせる
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_button 'ログイン'
    end
    context '一覧画面に遷移した場合' do
      it '登録済みのラベル一覧が表示される' do
        visit labels_path
        expect(page).to have_content 'ラベル一覧ページ'
      end
    end
  end
end