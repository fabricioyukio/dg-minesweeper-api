json.extract! game, :id, :name, :lines, :columns, :created_at, :updated_at
json.url game_url(game, format: :json)
