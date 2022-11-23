require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:user){FactoryBot.create(:user)}
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空文字の場合' do
      it 'バリデーションに失敗する' do
        task = Task.create(title: '', content: '企画書を作成する。')
        expect(task).not_to be_valid
      end
    end

    context 'タスクの説明が空文字の場合' do
      it 'バリデーションに失敗する' do
        task = Task.create(title: 'タスク', content: '')
        expect(task).to be_invalid
      end
    end

    context 'タスクのタイトルと説明に値が入っている場合' do
      it 'タスクを登録できる' do
        task = FactoryBot.create(:email_task, user: user)
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:first_task) { FactoryBot.create(:first_task, title: 'first_task_title', user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, title: "second_task_title", user: user) }
    let!(:third_task) { FactoryBot.create(:third_task, title: "third_task_title", user: user) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索ワードを含むタスクが絞り込まれる" do
        params = {"search"=>{"status"=>"", "title"=>"first"}, "commit"=>"検索"}
        
        expect(Task.search_title(params["search"]["title"])).to include(first_task)
        expect(Task.search_title(params["search"]["title"])).not_to include(second_task)
        expect(Task.search_title(params["search"]["title"])).not_to include(third_task)
        expect(Task.search_title(params["search"]["title"]).count).to eq 1
      end
    end

    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        params = {"search"=>{"status"=>"未着手", "title"=>""}, "commit"=>"検索"}
        expect(Task.search_status(params["search"]["status"])).to include(first_task)
        expect(Task.search_status(params["search"]["status"])).not_to include(second_task)
        expect(Task.search_status(params["search"]["status"])).not_to include(third_task)
        expect(Task.search_status(params["search"]["status"]).count).to eq 1
      end
    end

    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索ワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        params = {"search"=>{"status"=>"未着手", "title"=>"first"}, "commit"=>"検索"}
        expect(Task.search_status(params["search"]["status"]).search_title(params["search"]["title"])).to include(first_task)
        expect(Task.search_status(params["search"]["status"]).search_title(params["search"]["title"])).not_to include(second_task)
        expect(Task.search_status(params["search"]["status"]).search_title(params["search"]["title"])).not_to include(third_task)
        expect(Task.search_status(params["search"]["status"]).search_title(params["search"]["title"]).count).to eq 1
      end
    end
  end
end