FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'test_title' }
    content { 'test_content' }
    limit_on { DateTime.now }
    status { "未着手" }
    priority { "高" }
  end
  factory :second_task, class: Task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'test_title2' }
    content { 'test_content2' }
    limit_on { DateTime.now + 10 }
    status { "着手中" }
    priority { "高" }
  end
end
