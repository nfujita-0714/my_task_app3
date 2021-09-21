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
          task = Task.new(title: 'test_title', content: '成功', limit_on: "2021-10-10 00:00:00", status: "完了", priority: "高")
          expect(task).to be_valid
        end
      end
    end

    describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
      let!(:task) { FactoryBot.create(:task, title: 'test_title') }
      let!(:second_task) { FactoryBot.create(:second_task, title: "fujita") }

      context 'scopeメソッドでタイトルのあいまい検索をした場合' do
        it "検索キーワードを含むタスクが絞り込まれる" do
          # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
          expect(Task.search_title('test')).to include(task)
          expect(Task.search_title('test')).not_to include(second_task)
          expect(Task.search_title('test').count).to eq 1
        end
      end
      context 'scopeメソッドでステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          # ここに内容を記載する
          expect(Task.search_status('未着手')).to include(task)
          expect(Task.search_status('未着手')).not_to include(second_task)
          expect(Task.search_status('未着手').count).to eq 1
        end
      end
      context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          # ここに内容を記載する
          expect(Task.search_title('test')).to include(task) 
          expect(Task.search_title('test')).not_to include(second_task)
          expect(Task.search_title('test').count).to eq 1
          expect(Task.search_status('未着手')).to include(task)
          expect(Task.search_status('未着手')).not_to include(second_task)
          expect(Task.search_status('未着手').count).to eq 1
        end
      end
    end
  end
end
