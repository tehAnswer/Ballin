json.array!(@players) do |player|
  json.extract! player, :id, :name, :age, :height_cm, :height_formatted, :weight_lb, :weight_kg, :position, :number, :birthplace, :birthdate
  json.url player_url(player, format: :json)
end
