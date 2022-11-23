require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  let!(:user){FactoryBot.create(:user)}
  let!(:first){FactoryBot.create(:first_task, user: user)}
  let!(:second){FactoryBot.create(:second_task, user: user)}
  let!(:third){FactoryBot.create(:third_task, user: user)}
  
  describe '登録機能' do
    before do
      visit new_session_path #userをログインさせる
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_button 'ログイン'
    end
    context 'タスクを登録した場合' do
      it '登録したタスクが表示される' do
        
        click_on('タスクを登録する')
        fill_in('タイトル', with: 'かき揚げ')
        fill_in('内容', with: '書類作成')
        fill_in('終了期限', with: '2022-10-31')
        select('中', from: 'task[priority]')
        select('未着手', from: 'task[status]')
        click_button('登録する')
        expect(page).to have_content '書類作成'
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
      it '登録済みのタスク一覧が作成日時の降順で表示される' do
        Task.order("created_at DESC")
        visit tasks_path
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content 'first_task'
      end
    end

    context '新たにタスクを作成した場合' do
      it '新しいタスクが一番上に表示される' do
        visit new_task_path
        fill_in('タイトル', with: 'かき揚げ')
        fill_in('内容', with: '書類作成')
        fill_in('終了期限', with: '2022-10-31')
        select('中', from: 'task[priority]')
        select('未着手', from: 'task[status]')
        click_button('登録する')
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content 'かき揚げ'
      end
    end

    describe 'ソート機能' do
      context '「終了期限でソートする」というリンクをクリックした場合' do
        it '終了期限昇順に並び替えられたタスク一覧が表示される' do
          visit tasks_path
          click_link('終了期限')
          task_list = all('tbody tr')[0]
          expect(page).to have_content 'third_task'
        end
      end

      context '「優先度でソートする」というリンクをクリックした場合' do
        it "優先度の高い順に並び替えられたタスク一覧が表示される" do
          visit tasks_path
          click_link('優先度')
          task_list = all('tbody tr')[0]
          expect(page).to have_content 'second_task'
        end
      end
    end

    describe '検索機能' do
      context 'タイトルであいまい検索をした場合' do
        it '検索ワードを含むタスクのみ表示される' do
          visit tasks_path
          fill_in('タイトル', with: 'first')
          click_on('検索')
          task_list = all('tbody tr')
          expect(page).to have_content 'first_task'
          expect(page).not_to have_content 'second_task'
          expect(page).not_to have_content 'third_task'
        end
      end

      context 'ステータスで検索した場合' do
        it "検索したステータスに一致するタスクのみ表示される" do
          visit tasks_path
          select('着手中', from: 'ステータス')
          click_on('検索')
          task_list = all('tbody tr')
          expect(page).not_to have_content 'first_task'
          expect(page).to have_content '着手中'
          expect(page).not_to have_content 'third_task'
        end
      end

      context 'タイトルとステータスで検索した場合' do
        it "検索ワードをタイトルに含み、かつステータスに一致するタスクのみ表示される" do
          visit tasks_path
          select('着手中', from: 'ステータス')
          fill_in('タイトル', with: 'second')
          click_on('検索')
          task_list = all('tbody tr')
          expect(page).not_to have_content 'first_task'
          expect(page).to have_content 'second_task'
          expect(page).not_to have_content 'third_task'
        end
      end
    end
  end

  describe '詳細表示機能' do
  before do
    visit new_session_path #userをログインさせる
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password
    click_button 'ログイン'
  end
    context '任意のタスク詳細画面に遷移した場合' do
      it 'そのタスクの内容が表示される' do
        task = FactoryBot.create(:email_task, user: user)
        visit task_path(task.id)
        expect(page).to have_content '顧客へ営業のメールを送る。'
      end
    end
  end

  describe '優先度' do
    before do
      visit new_session_path #userをログインさせる
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_button 'ログイン'
    end
    context '優先度を降順にしたさい、title_11が取れる' do
      it 'task_title_11が表示される' do
        task = FactoryBot.create(:fainal_task, user: user)
        visit tasks_path
        click_link('優先度')
        task_list = all('tbody tr')
        expect(task_list[0].text).to have_content 'task_title_11'
      end
    end
  end

  
end