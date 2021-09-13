json.extract! task, :id, :title, :content, :user_id, :task_limit_on, :task_status, :created_at, :updated_at
json.url task_url(task, format: :json)
