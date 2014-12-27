object false

@meta.keys.each do |key|
  node(key){ @meta[key] }
end

collection @players, :root => :players, :object_root => false
extends "players/player"







