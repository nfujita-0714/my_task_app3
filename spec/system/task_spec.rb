require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

describe '検索機能' do
  before do
    # 必要に応じて、テストデータの内容を変更して構わない
    FactoryBot.create(:task, title: "test_title")
    FactoryBot.create(:second_task, title: "test_title2")
  end
  context 'タイトルであいまい検索をした場合' do
    it "検索キーワードを含むタスクで絞り込まれる" do
      visit tasks_path
      # タスクの検索欄に検索ワードを入力する (例: task)
      fill_in 'search_title', with: 'test_title'
      # 検索ボタンを押す
      click_on '検索'
      expect(page).to have_content 'test_title'
    end
  end
  context 'ステータス検索をした場合' do
    it "ステータスに完全一致するタスクが絞り込まれる" do
      # ここに実装する
      visit tasks_path
      # プルダウンを選択する「select」について調べてみること
      select '未着手',from: 'search_status'
      click_on '検索'
      expect(page).to have_content '未着手'
    end
  end
  context 'タイトルのあいまい検索とステータス検索をした場合' do
    it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
      # ここに実装する
      visit tasks_path
      fill_in 'search_title', with: 'test_title'
      select '未着手',from: 'search_status'
      click_on '検索'
      expect(page).to have_content 'test_title'
      expect(page).to have_content '未着手'
    end
  end
end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, title: 'task')
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
      # テスト内容を追加で記載する
      context 'タスクが作成日時の降順に並んでいる場合' do
        it '新しいタスクが一番上に表示される' do
          task = FactoryBot.create(:task)
          task = FactoryBot.create(:second_task)
          visit tasks_path
          task_list = all('tbody tr')
          expect(task_list[0]).to have_content 'test_title2'
          #expect(task_list[1]).to have_content 'test_title'
        end
      end
      context 'タスクが終了期限の降順に並んでいる場合' do
        it '終了期限が遠いタスクが一番上に表示される' do
          task = FactoryBot.create(:task, title: 'limit_far', limit_on:'2021-12-31 00:00:00')
          visit tasks_path
          task_list = all('.task_row')
          expect(task_list[0]).to have_content 'limit_far'
        end
      end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task)
        # task = FactoryBot.create(:second_task)
        visit task_path(task.id)
        expect(page).to have_content 'test_title'
      end
    end
  end
end
