require 'rails_helper'

RSpec.describe Task, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  describe 'タスクモデル機能', type: :model do
    describe 'バリデーションのテスト' do
      context 'タスクのタイトルが空の場合' do
        it 'バリデーションにひっかる' do
          task = Task.new(title: '', content: '失敗テスト')
          expect(task).not_to be_valid
        end
      end
      context 'タスクの詳細が空の場合' do
        it 'バリデーションにひっかかる' do
          # ここに内容を記載する
          task = Task.new(title: '', content: '失敗テスト')
          expect(task).not_to be_valid
        end
      end
      context 'タスクのタイトルと詳細に内容が記載されている場合' do
        it 'バリデーションが通る' do
          # ここに内容を記載する
          task = Task.new(title: 'test_title', content: '成功')
          expect(task).to be_valid
        end
      end
    end

    describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
      let!(:task) { FactoryBot.create(:task, title: 'test_title') }
      let!(:second_task) { FactoryBot.create(:second_task, title: "test_title2") }

      context 'scopeメソッドでタイトルのあいまい検索をした場合' do
        it "検索キーワードを含むタスクが絞り込まれる" do
          # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
          expect(Task.title_search('test_title')).to include(task)
          expect(Task.title_search('test_title')).not_to include(second_task)
          expect(Task.title_search('test_title').count).to eq 1
        end
      end
      context 'scopeメソッドでステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          # ここに内容を記載する
          expect(Task.status_search('未着手')).to include(task)
          expect(Task.status_search('未着手')).not_to include(second_task)
          expect(Task.status_search('未着手').count).to eq 1
        end
      end
      context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          # ここに内容を記載する
        end
      end
    end
  end
end
