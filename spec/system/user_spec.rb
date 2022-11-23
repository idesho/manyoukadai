require 'rails_helper'

RSpec.describe 'ユーザ管理機能', type: :system do
  describe '登録機能' do
    context 'ユーザを登録した場合' do
      it 'タスク一覧画面に遷移する' do
        visit new_user_path
        fill_in('名前', with: '太郎')
        fill_in('メールアドレス', with: '24353253455@sample.com')
        fill_in('パスワード', with: 'password')
        fill_in('パスワード（確認）', with: 'password')
        click_on('登録する')
        expect(page).to have_content 'タスク一覧ページ'
      end
    end
    context 'ログインせずにタスク一覧画面に遷移した場合' do
      it 'ログイン画面に遷移し、「ログインしてください」というメッセージが表示される' do
        visit tasks_path
        expect(page).to have_content 'ログインページ'
        expect(page).to have_content 'ログインしてください'
      end
    end
  end
  describe 'ログイン機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:current_user) { FactoryBot.create(:current_user) }
    before do
      visit new_session_path #userをログインさせる
      fill_in('メールアドレス', with: '123456@sample.com')
      fill_in('パスワード', with: 'password')
      click_button('ログイン')
    end
    context '登録済みのユーザでログインした場合' do
      it 'タスク一覧画面に遷移し、「ログインしました」というメッセージが表示される' do
        expect(page).to have_content 'ログインしました'
      end
      it '自分の詳細画面にアクセスできる' do
        click_on('アカウント詳細')
        expect(page).to have_content 'アカウント詳細ページ'
      end
      it '他人の詳細画面にアクセスすると、タスク一覧画面に遷移する' do
        visit user_path(current_user.id)
        expect(page).to have_content 'タスク一覧ページ'
      end
      it 'ログアウトするとログイン画面に遷移し、「ログアウトしました」というメッセージが表示される' do
        click_on('ログアウト')
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理者機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:current_user) { FactoryBot.create(:current_user) }
    before do
      visit new_session_path #current_userをログインさせる
      fill_in('メールアドレス', with: '999999929292@sample.com')
      fill_in('パスワード', with: 'password')
      click_button('ログイン')
    end
    context '管理者がログインした場合' do
      it 'ユーザ一覧画面にアクセスできる' do
        click_on('ユーザ一覧')
        expect(page).to have_content 'ユーザ一覧ページ'
      end
      it '管理者を登録できる' do
        click_on('ユーザを登録する')
        fill_in('名前', with: '花子')
        fill_in('メールアドレス', with: 'hanahana@sample.com')
        fill_in('パスワード', with: 'password')
        fill_in('パスワード(確認)', with: 'password')
        check('管理者権限')
        click_on('登録する')
        expect(page).to have_content 'ユーザを登録しました'
      end
      it 'ユーザ詳細画面にアクセスできる' do
        visit admin_user_path(current_user.id)
        expect(page).to have_content 'ユーザ詳細ページ'
      end
      it 'ユーザ編集画面から、自分以外のユーザを編集できる' do
        visit edit_admin_user_path(user.id)
        fill_in('パスワード', with: 'password')
        fill_in('パスワード（確認）', with: 'password')
        click_on('更新する')
        expect(page).to have_content 'ユーザを更新しました'
      end
      it 'ユーザを削除できる' do
        click_on('ユーザ一覧')
        User.order("id")
        page.accept_confirm do #alertが出た際にはいをクリックする
          all('tbody tr')[0].click_link '削除'
        end
        expect(page).to have_content 'ユーザを削除しました'
      end
    end
    context '一般ユーザがユーザ一覧画面にアクセスした場合' do
      it 'タスク一覧画面に遷移し、「管理者以外アクセスできません」というエラーメッセージが表示される' do
        click_on('ログアウト')
        fill_in('メールアドレス', with: '123456@sample.com')
        fill_in('パスワード', with: 'password')
        click_button('ログイン')
        visit admin_users_path
        expect(page).to have_content "管理者以外はアクセスできません"
      end
    end
  end
end