FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'test_title' }
    contents { 'test_content' }
  end
  factory :second_task, class: Task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'test_title2' }
    contents { 'test_content2' }
  end
end