json.extract! todo, :id, :user_id, :title, :content, :start_on, :end_on, :is_finished, :created_at, :updated_at
json.url todo_url(todo, format: :json)
