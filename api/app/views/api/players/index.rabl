collection @players, :root => :players, :object_root => false
extends "api/players/player"

node(:meta) do
  paginate(@page, @players)
end

